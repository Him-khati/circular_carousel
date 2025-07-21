import 'cache_factory.dart';
import 'cache_strategy.dart';
import 'cache_manager.dart';

class ExampleCacheViewModel {
  final CacheManager<String> cache;
  ExampleCacheViewModel({CacheStrategy strategy = CacheStrategy.inMemory, String? boxName})
      : cache = CacheFactory<String>.create(strategy, boxName: boxName);

  Future<String> fetchData(String key) async {
    final cached = await cache.get(key);
    if (cached != null) return cached;
    // Simulate API call
    final data = 'Fetched data for $key at \\${DateTime.now()}';
    await cache.set(key, data, ttl: Duration(seconds: 5));
    return data;
  }

  Future<void> invalidate(String key) => cache.invalidate(key);
  Future<void> clearAll() => cache.clearAll();
}