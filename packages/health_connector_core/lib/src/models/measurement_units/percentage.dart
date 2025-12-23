part of 'measurement_unit.dart';

/// Represents a percentage value with automatic unit conversion.
///
/// Percentage is used for body fat percentage, blood oxygen saturation,
/// and other percentage-based health data.
///
/// Percentages are stored internally as decimal values (0.0 to 1.0),
/// where:
/// - 0.0 = 0%
/// - 0.25 = 25%
/// - 1.0 = 100%
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Percentage extends MeasurementUnit
    implements Comparable<Percentage> {
  const Percentage._(this._value);

  /// Creates a percentage from a decimal value (0.0 to 1.0).
  ///
  /// Example:
  /// ```dart
  /// final percentage = Percentage.fromDecimal(0.25);
  /// print(percentage.asWhole); // 25.0
  /// ```
  const Percentage.fromDecimal(double value) : _value = value;

  /// Creates a percentage from a whole number value (0 to 100).
  ///
  /// Example:
  /// ```dart
  /// final percentage = Percentage.fromWhole(25);
  /// print(percentage.asDecimal); // 0.25
  /// ```
  const Percentage.fromWhole(double value) : _value = value / 100;

  /// A percentage of zero (0%).
  static const Percentage zero = Percentage._(0.0);

  /// A percentage of 100%.
  static const Percentage full = Percentage._(1.0);

  /// Tolerance for floating-point comparison.
  static const double _tolerance = 0.0001;

  /// The percentage value stored as a decimal (0.0 to 1.0).
  final double _value;

  /// Returns the percentage as a decimal (0.0 to 1.0).
  ///
  /// Example:
  /// ```dart
  /// final percentage = Percentage.fromWhole(25);
  /// print(percentage.asDecimal); // 0.25
  /// ```
  double get asDecimal => _value;

  /// Returns the percentage as a whole number (0 to 100).
  ///
  /// Example:
  /// ```dart
  /// final percentage = Percentage.fromDecimal(0.25);
  /// print(percentage.asWhole); // 25.0
  /// ```
  double get asWhole => _value * 100;

  /// Adds two percentage values together.
  ///
  /// Example:
  /// ```dart
  /// final p1 = Percentage.fromWhole(15);
  /// final p2 = Percentage.fromWhole(10);
  /// final total = p1 + p2;
  /// print(total.asWhole); // 25.0
  /// ```
  Percentage operator +(Percentage other) =>
      Percentage._(_value + other._value);

  /// Subtracts one percentage value from another.
  ///
  /// Example:
  /// ```dart
  /// final p1 = Percentage.fromWhole(25);
  /// final p2 = Percentage.fromWhole(10);
  /// final diff = p1 - p2;
  /// print(diff.asWhole); // 15.0
  /// ```
  Percentage operator -(Percentage other) =>
      Percentage._(_value - other._value);

  /// Returns true if this percentage is greater than [other].
  bool operator >(Percentage other) => _value > other._value;

  /// Returns true if this percentage is less than [other].
  bool operator <(Percentage other) => _value < other._value;

  /// Returns true if this percentage is greater than or equal to [other].
  bool operator >=(Percentage other) => _value >= other._value;

  /// Returns true if this percentage is less than or equal to [other].
  bool operator <=(Percentage other) => _value <= other._value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Percentage &&
          runtimeType == other.runtimeType &&
          (_value - other._value).abs() < _tolerance;

  @override
  int get hashCode => (_value / _tolerance).round().hashCode;

  @override
  int compareTo(Percentage other) => _value.compareTo(other._value);

  @override
  String toString() => '${asWhole.toStringAsFixed(1)}%';
}
