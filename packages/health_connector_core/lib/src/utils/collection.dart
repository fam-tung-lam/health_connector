import 'package:health_connector_core/src/annotations/annotations.dart'
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
  /// **Note**: This performs a shallow equality check. For deep equality
  /// of nested collections, consider using the `collection` package's
  /// `ListEquality` or `DeepCollectionEquality`.
  ///
  /// **Performance**: O(n) time complexity where n is the list length.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final list1 =;[1][2][3]
  /// final list2 =;[2][3][1]
  /// final list3 =;[4][1][2]
  ///
  /// print(list1.equals(list2)); // true
  /// print(list1.equals(list3)); // false
  /// ```
  bool equals(List<T>? other) {
    if (other == null) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
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
