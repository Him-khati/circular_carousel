import 'dart:core';

typedef GetValue = int Function<T>(T value);

extension IterableNullSafetyExtension<T> on Iterable<T> {
  T minValue(double Function(T) cc) {
    return reduce((a, b) {
      if (cc(a) < cc(b)) {
        return a;
      } else {
        return b;
      }
    });
  }
}
