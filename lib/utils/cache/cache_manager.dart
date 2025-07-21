abstract class CacheManager<T> {
  Future<T?> get(String key);
  Future<void> set(String key, T value, {Duration? ttl});
  Future<void> invalidate(String key);
  Future<void> clearAll();
}