import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_flutter/utils/cache/in_memory_cache_manager.dart';
import 'package:carousel_flutter/utils/cache/cache_entry.dart';
import 'package:carousel_flutter/utils/cache/disk_cache_manager.dart';
import 'package:hive/hive.dart';
import 'dart:io';

void main() {
  group('InMemoryCacheManager', () {
    late InMemoryCacheManager<String> cache;
    setUp(() {
      cache = InMemoryCacheManager<String>();
    });

    test('set and get cache', () async {
      await cache.set('foo', 'bar');
      expect(await cache.get('foo'), 'bar');
    });

    test('invalidate cache', () async {
      await cache.set('foo', 'bar');
      await cache.invalidate('foo');
      expect(await cache.get('foo'), isNull);
    });

    test('clearAll cache', () async {
      await cache.set('foo', 'bar');
      await cache.set('baz', 'qux');
      await cache.clearAll();
      expect(await cache.get('foo'), isNull);
      expect(await cache.get('baz'), isNull);
    });

    test('cache entry expires', () async {
      await cache.set('foo', 'bar', ttl: Duration(milliseconds: 100));
      await Future.delayed(Duration(milliseconds: 150));
      expect(await cache.get('foo'), isNull);
    });
  });

  group('DiskCacheManager', () {
    late DiskCacheManager<String> cache;
    setUpAll(() async {
      final dir = Directory.systemTemp.createTempSync();
      Hive.init(dir.path);
    });
    setUp(() async {
      cache = DiskCacheManager<String>('testBox');
      await cache.clearAll();
    });

    test('set and get cache', () async {
      await cache.set('foo', 'bar');
      expect(await cache.get('foo'), 'bar');
    });

    test('invalidate cache', () async {
      await cache.set('foo', 'bar');
      await cache.invalidate('foo');
      expect(await cache.get('foo'), isNull);
    });

    test('clearAll cache', () async {
      await cache.set('foo', 'bar');
      await cache.set('baz', 'qux');
      await cache.clearAll();
      expect(await cache.get('foo'), isNull);
      expect(await cache.get('baz'), isNull);
    });

    test('cache entry expires', () async {
      await cache.set('foo', 'bar', ttl: Duration(milliseconds: 100));
      await Future.delayed(Duration(milliseconds: 150));
      expect(await cache.get('foo'), isNull);
    });
  });
}