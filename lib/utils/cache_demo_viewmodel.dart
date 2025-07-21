import 'dart:async';
import 'cache_manager.dart';

class CacheDemoViewModel {
  final CombinedCacheManager cacheManager;
  static const String _demoKey = 'demo_data';

  CacheDemoViewModel(this.cacheManager);

  /// Simulate fetching data from an API
  Future<String> fetchDataFromApi() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Fetched at  [32m${DateTime.now()} [0m';
  }

  /// Get data, using cache if available
  Future<String> getData() async {
    final cached = await cacheManager.get<String>(_demoKey);
    if (cached != null) {
      return '[CACHE] $cached';
    }
    final data = await fetchDataFromApi();
    await cacheManager.set(_demoKey, data, ttl: const Duration(seconds: 10));
    return '[API] $data';
  }

  /// Invalidate the cache for the demo key
  Future<void> invalidateCache() async {
    await cacheManager.invalidate(_demoKey);
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await cacheManager.clearAll();
  }
}