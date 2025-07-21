import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract cache manager interface
abstract class CacheManager {
  FutureOr<void> set(String key, dynamic value, {Duration? ttl});
  FutureOr<T?> get<T>(String key);
  FutureOr<void> invalidate(String key);
  FutureOr<void> clearAll();
}

/// In-memory cache implementation
class InMemoryCache implements CacheManager {
  final Map<String, _CacheEntry> _cache = {};

  @override
  void set(String key, dynamic value, {Duration? ttl}) {
    final expiry = ttl != null ? DateTime.now().add(ttl) : null;
    _cache[key] = _CacheEntry(value, expiry);
  }

  @override
  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null) return null;
    if (entry.expiry != null && entry.expiry!.isBefore(DateTime.now())) {
      _cache.remove(key);
      return null;
    }
    return entry.value as T?;
  }

  @override
  void invalidate(String key) {
    _cache.remove(key);
  }

  @override
  void clearAll() {
    _cache.clear();
  }
}

class _CacheEntry {
  final dynamic value;
  final DateTime? expiry;
  _CacheEntry(this.value, this.expiry);
}

/// Disk cache implementation using shared_preferences
class DiskCache implements CacheManager {
  static const _ttlSuffix = '_ttl';

  @override
  Future<void> set(String key, dynamic value, {Duration? ttl}) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(value);
    await prefs.setString(key, encoded);
    if (ttl != null) {
      final expiry = DateTime.now().add(ttl).millisecondsSinceEpoch;
      await prefs.setInt(key + _ttlSuffix, expiry);
    } else {
      await prefs.remove(key + _ttlSuffix);
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final expiry = prefs.getInt(key + _ttlSuffix);
    if (expiry != null && DateTime.now().millisecondsSinceEpoch > expiry) {
      await invalidate(key);
      return null;
    }
    final encoded = prefs.getString(key);
    if (encoded == null) return null;
    return jsonDecode(encoded) as T?;
  }

  @override
  Future<void> invalidate(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.remove(key + _ttlSuffix);
  }

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

/// Combined cache manager (strategy pattern)
class CombinedCacheManager implements CacheManager {
  final InMemoryCache memoryCache;
  final DiskCache diskCache;
  final bool useMemoryFirst;

  CombinedCacheManager({
    required this.memoryCache,
    required this.diskCache,
    this.useMemoryFirst = true,
  });

  @override
  Future<void> set(String key, dynamic value, {Duration? ttl}) async {
    memoryCache.set(key, value, ttl: ttl);
    await diskCache.set(key, value, ttl: ttl);
  }

  @override
  Future<T?> get<T>(String key) async {
    if (useMemoryFirst) {
      final memValue = memoryCache.get<T>(key);
      if (memValue != null) return memValue;
      final diskValue = await diskCache.get<T>(key);
      if (diskValue != null) memoryCache.set(key, diskValue);
      return diskValue;
    } else {
      final diskValue = await diskCache.get<T>(key);
      if (diskValue != null) memoryCache.set(key, diskValue);
      return diskValue;
    }
  }

  @override
  Future<void> invalidate(String key) async {
    memoryCache.invalidate(key);
    await diskCache.invalidate(key);
  }

  @override
  Future<void> clearAll() async {
    memoryCache.clearAll();
    await diskCache.clearAll();
  }
}