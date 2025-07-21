import 'package:hive/hive.dart';
import 'cache_entry.dart';
import 'cache_manager.dart';

class DiskCacheManager<T> implements CacheManager<T> {
  final String boxName;
  Box? _box;

  DiskCacheManager(this.boxName);

  Future<Box> _openBox() async {
    if (_box?.isOpen == true) return _box!;
    _box = await Hive.openBox(boxName);
    return _box!;
  }

  @override
  Future<T?> get(String key) async {
    final box = await _openBox();
    final map = box.get(key);
    if (map == null) return null;
    final entry = CacheEntry<T>(
      map['value'] as T,
      expiry: map['expiry'] != null ? DateTime.parse(map['expiry']) : null,
    );
    if (entry.isExpired) {
      await invalidate(key);
      return null;
    }
    return entry.value;
  }

  @override
  Future<void> set(String key, T value, {Duration? ttl}) async {
    final box = await _openBox();
    final expiry = ttl != null ? DateTime.now().add(ttl) : null;
    await box.put(key, {
      'value': value,
      'expiry': expiry?.toIso8601String(),
    });
  }

  @override
  Future<void> invalidate(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }
}