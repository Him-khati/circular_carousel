import 'cache_entry.dart';
import 'cache_manager.dart';

class InMemoryCacheManager<T> implements CacheManager<T> {
  final _cache = <String, CacheEntry<T>>{};

  @override
  Future<T?> get(String key) async {
    final entry = _cache[key];
    if (entry == null || entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry.value;
  }

  @override
  Future<void> set(String key, T value, {Duration? ttl}) async {
    final expiry = ttl != null ? DateTime.now().add(ttl) : null;
    _cache[key] = CacheEntry<T>(value, expiry: expiry);
  }

  @override
  Future<void> invalidate(String key) async {
    _cache.remove(key);
  }

  @override
  Future<void> clearAll() async {
    _cache.clear();
  }
}