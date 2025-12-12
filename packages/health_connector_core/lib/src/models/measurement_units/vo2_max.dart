part of 'measurement_unit.dart';

/// Represents a VO₂ max (maximal oxygen uptake) measurement.
///
/// VO₂ max is expressed in milliliters of oxygen consumed per kilogram
/// of body weight per minute (mL/kg/min).
@immutable
final class Vo2Max extends MeasurementUnit implements Comparable<Vo2Max> {
  const Vo2Max._(this._value);

  /// Creates a VO₂ max measurement from a value in mL/kg/min.
  ///
  /// This is the standard unit for VO₂ max measurements.
  /// ```
  const Vo2Max.millilitersPerKilogramPerMinute(double value) : _value = value;

  /// A VO₂ max of zero.
  static const Vo2Max zero = Vo2Max._(0.0);

  /// Tolerance for floating-point comparison (0.01 mL/kg/min).
  static const double _tolerance = 0.01;

  /// The VO₂ max value stored in mL/kg/min (base unit).
  final double _value;

  /// Returns the VO₂ max value in mL/kg/min.
  double get value => _value;

  /// Adds two VO₂ max values together.
  Vo2Max operator +(Vo2Max other) => Vo2Max._(_value + other._value);

  /// Subtracts one VO₂ max value from another.
  Vo2Max operator -(Vo2Max other) => Vo2Max._(_value - other._value);

  /// Returns true if this VO₂ max is greater than [other].
  bool operator >(Vo2Max other) => _value > other._value;

  /// Returns true if this VO₂ max is less than [other].
  bool operator <(Vo2Max other) => _value < other._value;

  /// Returns true if this VO₂ max is greater than or equal to [other].
  bool operator >=(Vo2Max other) => _value >= other._value;

  /// Returns true if this VO₂ max is less than or equal to [other].
  bool operator <=(Vo2Max other) => _value <= other._value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2Max &&
          runtimeType == other.runtimeType &&
          (_value - other._value).abs() < _tolerance;

  @override
  int get hashCode => (_value / _tolerance).round().hashCode;

  @override
  int compareTo(Vo2Max other) => _value.compareTo(other._value);

  @override
  String get name => 'vo2_max';

  @override
  String toString() => '${_value.toStringAsFixed(1)} mL/kg/min';
}
