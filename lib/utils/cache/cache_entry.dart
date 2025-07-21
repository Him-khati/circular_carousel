class CacheEntry<T> {
  final T value;
  final DateTime? expiry;

  CacheEntry(this.value, {this.expiry});

  bool get isExpired => expiry != null && DateTime.now().isAfter(expiry!);
}