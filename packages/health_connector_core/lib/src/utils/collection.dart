import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show internal;

/// Utility extensions for collection types.
///
/// This file provides extension methods for common collection operations,
/// such as list comparison.
@sinceV1_0_0
@internal
extension ListEquality<T> on List<T> {
  /// Checks if this list is equal to [other] by comparing elements in order.
  ///
  /// Returns `true` if both lists have the same length and all elements at
  /// corresponding positions are equal (using `==`). Returns `false` otherwise.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final list1 = [1, 2, 3];
  /// final list2 = [1, 2, 3];
  /// final list3 = [1, 2, 4];
  ///
  /// print(list1.equals(list2)); // true
  /// print(list1.equals(list3)); // false
  /// ```
  bool equals(List<T> other) {
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
