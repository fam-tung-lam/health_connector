part of 'measurement_unit.dart';

/// Represents a numeric value without unit conversion.
///
/// Number is used for simple count values like step counts, where there is
/// no meaningful unit conversion (steps are always just steps).
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Number extends MeasurementUnit implements Comparable<Number> {
  /// Creates a number with the given value.
  const Number(this.value);

  /// The numeric value.
  final num value;

  /// A numeric value of zero.
  static const Number zero = Number(0);

  /// Adds this number to [other].
  Number operator +(Number other) => Number(value + other.value);

  /// Subtracts [other] from this number.
  Number operator -(Number other) => Number(value - other.value);

  /// Returns true if this number is greater than [other].
  bool operator >(Number other) => value > other.value;

  /// Returns true if this number is less than [other].
  bool operator <(Number other) => value < other.value;

  /// Returns true if this number is greater than or equal to [other].
  bool operator >=(Number other) => value >= other.value;

  /// Returns true if this number is less than or equal to [other].
  bool operator <=(Number other) => value <= other.value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Number &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(Number other) => value.compareTo(other.value);
  @override
  String toString() => value.toString();
}
