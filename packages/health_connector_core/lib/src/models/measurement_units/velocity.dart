part of 'measurement_unit.dart';

/// Represents a velocity (speed) measurement with automatic unit conversion.
///
/// Velocity is used for running speed, cycling speed, and other
/// speed-related health data.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Velocity extends MeasurementUnit implements Comparable<Velocity> {
  const Velocity._(this._metersPerSecond);

  /// Creates a velocity from a value in meters per second.
  ///
  /// ## Parameters
  ///
  /// - [value]: The velocity value in meters per second.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.metersPerSecond(2.78);
  /// print(velocity.inMetersPerSecond); // 2.78
  /// ```
  const Velocity.metersPerSecond(double value) : _metersPerSecond = value;

  /// Creates a velocity from a value in kilometers per hour.
  ///
  /// ## Parameters
  ///
  /// - [value]: The velocity value in kilometers per hour.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.kilometersPerHour(10);
  /// print(velocity.inMetersPerSecond); // ~2.78
  /// ```
  const Velocity.kilometersPerHour(double value)
    : _metersPerSecond = value / _kmhToMsConversionFactor;

  /// Creates a velocity from a value in miles per hour.
  ///
  /// ## Parameters
  ///
  /// - [value]: The velocity value in miles per hour.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.milesPerHour(6.21);
  /// print(velocity.inMetersPerSecond); // ~2.78
  /// ```
  const Velocity.milesPerHour(double value)
    : _metersPerSecond = value * _metersPerSecondPerMph;

  /// A velocity of zero meters per second.
  static const Velocity zero = Velocity._(0.0);

  /// Tolerance for floating-point comparison (0.01 m/s).
  static const double _tolerance = 0.01;

  /// Conversion factor from km/h to m/s.
  ///
  /// 1 m/s = 3.6 km/h
  static const double _kmhToMsConversionFactor = 3.6;

  /// Conversion factor from mph to m/s.
  ///
  /// 1 mph = 0.44704 m/s
  static const double _metersPerSecondPerMph = 0.44704;

  /// The velocity value stored in meters per second (base unit).
  final double _metersPerSecond;

  /// Returns the velocity in meters per second.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.kilometersPerHour(10);
  /// print(velocity.inMetersPerSecond); // ~2.78
  /// ```
  double get inMetersPerSecond => _metersPerSecond;

  /// Returns the velocity in kilometers per hour.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.metersPerSecond(2.78);
  /// print(velocity.inKilometersPerHour); // ~10.0
  /// ```
  double get inKilometersPerHour => _metersPerSecond * _kmhToMsConversionFactor;

  /// Returns the velocity in miles per hour.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final velocity = Velocity.metersPerSecond(2.78);
  /// print(velocity.inMilesPerHour); // ~6.21
  /// ```
  double get inMilesPerHour => _metersPerSecond / _metersPerSecondPerMph;

  /// Adds two velocities together.
  Velocity operator +(Velocity other) =>
      Velocity._(_metersPerSecond + other._metersPerSecond);

  /// Subtracts one velocity from another.
  Velocity operator -(Velocity other) =>
      Velocity._(_metersPerSecond - other._metersPerSecond);

  /// Returns true if this velocity is greater than [other].
  bool operator >(Velocity other) => _metersPerSecond > other._metersPerSecond;

  /// Returns true if this velocity is less than [other].
  bool operator <(Velocity other) => _metersPerSecond < other._metersPerSecond;

  /// Returns true if this velocity is greater than or equal to [other].
  bool operator >=(Velocity other) =>
      _metersPerSecond >= other._metersPerSecond;

  /// Returns true if this velocity is less than or equal to [other].
  bool operator <=(Velocity other) =>
      _metersPerSecond <= other._metersPerSecond;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Velocity &&
          runtimeType == other.runtimeType &&
          (_metersPerSecond - other._metersPerSecond).abs() < _tolerance;

  @override
  int get hashCode => (_metersPerSecond / _tolerance).round().hashCode;

  @override
  int compareTo(Velocity other) =>
      _metersPerSecond.compareTo(other._metersPerSecond);

  @override
  String toString() => '${_metersPerSecond.toStringAsFixed(2)} m/s';
}
