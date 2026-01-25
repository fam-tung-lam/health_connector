part of 'measurement_unit.dart';

/// Represents a power measurement with automatic unit conversion.
///
/// Power is used for cycling power output, rowing power, and
/// other power-related exercise data.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class Power extends MeasurementUnit implements Comparable<Power> {
  const Power._(this._watts);

  /// Creates a power value from watts.
  ///
  /// ## Parameters
  ///
  /// - [value]: The power value in watts.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.watts(250);
  /// print(power.inWatts); // 250.0
  /// ```
  const Power.watts(double value) : _watts = value;

  /// Creates a power value from kilowatts.
  ///
  /// ## Parameters
  ///
  /// - [value]: The power value in kilowatts.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.kilowatts(0.25);
  /// print(power.inWatts); // 250.0
  /// ```
  const Power.kilowatts(double value) : _watts = value * _wattsPerKilowatt;

  /// Creates a power value from kilocalories per day.
  ///
  /// This is used for basal metabolic rate (BMR) measurements, which represent
  /// the energy a user would burn if at rest all day.
  ///
  /// ## Parameters
  ///
  /// - [value]: The power value in kilocalories per day.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.kilocaloriesPerDay(2000);
  /// print(power.inKilocaloriesPerDay); // 2000.0
  /// ```
  @sinceV3_6_0
  const Power.kilocaloriesPerDay(double value)
    : _watts = value * _wattsPerKilocaloriePerDay;

  /// A power of zero watts.
  static const Power zero = Power._(0.0);

  /// Tolerance for floating-point comparison (0.1 watts).
  static const double _tolerance = 0.1;

  /// Conversion factor from watts to kilowatts.
  static const double _wattsPerKilowatt = 1000;

  /// Conversion factor from kilocalories per day to watts.
  ///
  /// 1 kcal/day = 1 kcal / 86400 s = 4184 J / 86400 s ≈ 0.0484259259 W
  static const double _wattsPerKilocaloriePerDay = 4184 / 86400;

  /// The power value stored in watts (base unit).
  final double _watts;

  /// Returns the power in watts.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.kilowatts(0.25);
  /// print(power.inWatts); // 250.0
  /// ```
  double get inWatts => _watts;

  /// Returns the power in kilowatts.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.watts(250);
  /// print(power.inKilowatts); // 0.25
  /// ```
  double get inKilowatts => _watts / _wattsPerKilowatt;

  /// Returns the power in kilocalories per day.
  ///
  /// This is used for basal metabolic rate (BMR) measurements.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final power = Power.kilocaloriesPerDay(2000);
  /// print(power.inKilocaloriesPerDay); // 2000.0
  /// ```
  @sinceV3_6_0
  double get inKilocaloriesPerDay => _watts / _wattsPerKilocaloriePerDay;

  /// Adds two power values together.
  Power operator +(Power other) => Power._(_watts + other._watts);

  /// Subtracts one power value from another.
  Power operator -(Power other) => Power._(_watts - other._watts);

  /// Returns true if this power is greater than [other].
  bool operator >(Power other) => _watts > other._watts;

  /// Returns true if this power is less than [other].
  bool operator <(Power other) => _watts < other._watts;

  /// Returns true if this power is greater than or equal to [other].
  bool operator >=(Power other) => _watts >= other._watts;

  /// Returns true if this power is less than or equal to [other].
  bool operator <=(Power other) => _watts <= other._watts;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Power &&
          runtimeType == other.runtimeType &&
          (_watts - other._watts).abs() < _tolerance;

  @override
  int get hashCode => (_watts / _tolerance).round().hashCode;

  @override
  int compareTo(Power other) => _watts.compareTo(other._watts);

  @override
  String toString() => '${_watts.toStringAsFixed(1)} W';
}
