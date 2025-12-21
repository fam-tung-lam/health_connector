part of 'measurement_unit.dart';

/// Represents a numeric value without unit conversion.
///
/// Number is used for simple count values like step counts, where there is
/// no meaningful unit conversion (steps are always just steps).
@sinceV1_0_0
@immutable
final class Number extends MeasurementUnit implements Comparable<Number> {
  const Number(this.value);

  /// The numeric value.
  final num value;

  /// A numeric value of zero.
  static const Number zero = Number(0);

  Number operator +(Number other) => Number(value + other.value);

  Number operator -(Number other) => Number(value - other.value);

  bool operator >(Number other) => value > other.value;

  bool operator <(Number other) => value < other.value;

  bool operator >=(Number other) => value >= other.value;

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
  String get name => 'number';

  @override
  String toString() => value.toString();
}
