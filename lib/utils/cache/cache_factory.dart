import 'cache_manager.dart';
import 'in_memory_cache_manager.dart';
import 'disk_cache_manager.dart';
import 'cache_strategy.dart';

class CacheFactory<T> {
  static CacheManager<T> create(CacheStrategy strategy, {String? boxName}) {
    switch (strategy) {
      case CacheStrategy.inMemory:
        return InMemoryCacheManager<T>();
      case CacheStrategy.disk:
        if (boxName == null) throw ArgumentError('boxName required for disk cache');
        return DiskCacheManager<T>(boxName);
      case CacheStrategy.both:
        // For demonstration, return in-memory. You can implement a hybrid manager if needed.
        return InMemoryCacheManager<T>();
    }
  }
}