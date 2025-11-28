part of 'measurement_unit.dart';

/// Represents a numeric value without unit conversion.
///
/// Numeric is used for simple count values like step counts, where there is
/// no meaningful unit conversion (steps are always just steps).
@sinceV1_0_0
@immutable
final class Numeric extends MeasurementUnit implements Comparable<Numeric> {
  /// Creates a numeric value.
  ///
  /// Example:
  /// ```dart
  /// final steps = Numeric(1234);
  /// print(steps.value); // 1234
  /// ```
  const Numeric(this.value);

  /// A numeric value of zero.
  static const Numeric zero = Numeric(0);

  /// The numeric value.
  final num value;

  /// Adds two numeric values together.
  ///
  /// Example:
  /// ```dart
  /// final n1 = Numeric(1000);
  /// final n2 = Numeric(500);
  /// final total = n1 + n2;
  /// print(total.value); // 1500
  /// ```
  Numeric operator +(Numeric other) => Numeric(value + other.value);

  /// Subtracts one numeric value from another.
  ///
  /// Example:
  /// ```dart
  /// final n1 = Numeric(2000);
  /// final n2 = Numeric(500);
  /// final diff = n1 - n2;
  /// print(diff.value); // 1500
  /// ```
  Numeric operator -(Numeric other) => Numeric(value - other.value);

  /// Returns true if this numeric value is greater than [other].
  bool operator >(Numeric other) => value > other.value;

  /// Returns true if this numeric value is less than [other].
  bool operator <(Numeric other) => value < other.value;

  /// Returns true if this numeric value is greater than or equal to [other].
  bool operator >=(Numeric other) => value >= other.value;

  /// Returns true if this numeric value is less than or equal to [other].
  bool operator <=(Numeric other) => value <= other.value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Numeric &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(Numeric other) {
    if (value < other.value) {
      return -1;
    }
    if (value > other.value) {
      return 1;
    }
    return 0;
  }

  @override
  String get name => 'numeric';

  @override
  String toString() => value.toString();
}
