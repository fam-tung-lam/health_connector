part of 'measurement_unit.dart';

/// Represents a pressure measurement with automatic unit conversion.
///
/// Pressure is primarily used for blood pressure measurements.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Pressure extends MeasurementUnit implements Comparable<Pressure> {
  const Pressure._(this._millimetersOfMercury);

  /// Creates a pressure from a value in millimeters of mercury.
  ///
  /// This is the standard unit for blood pressure measurements.
  ///
  /// ## Parameters
  ///
  /// - [value]: The pressure value in millimeters of mercury.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final pressure = Pressure.millimetersOfMercury(120);
  /// print(pressure.inMillimetersOfMercury); // 120.0
  /// ```
  const Pressure.millimetersOfMercury(double value)
    : _millimetersOfMercury = value;

  /// Creates a pressure from a value in pascals.
  ///
  /// ## Parameters
  ///
  /// - [value]: The pressure value in pascals.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final pressure = Pressure.pascals(15998.7);
  /// print(pressure.inMillimetersOfMercury); // ~120.0
  /// ```
  const Pressure.pascals(double value)
    : _millimetersOfMercury = value / _pascalsPerMmHg;

  /// A pressure of zero millimeters of mercury.
  static const Pressure zero = Pressure._(0.0);

  /// Tolerance for floating-point comparison (0.1 mmHg).
  static const double _tolerance = 0.1;

  /// Conversion factor from mmHg to pascals.
  ///
  /// 1 mmHg = 133.322 Pa
  static const double _pascalsPerMmHg = 133.322;

  /// The pressure value stored in millimeters of mercury (base unit).
  final double _millimetersOfMercury;

  /// Returns the pressure in millimeters of mercury.
  ///
  /// This is the standard unit for blood pressure.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final pressure = Pressure.pascals(15998.7);
  /// print(pressure.inMillimetersOfMercury); // ~120.0
  /// ```
  double get inMillimetersOfMercury => _millimetersOfMercury;

  /// Returns the pressure in pascals.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final pressure = Pressure.millimetersOfMercury(120);
  /// print(pressure.inPascals); // ~15998.7
  /// ```
  double get inPascals => _millimetersOfMercury * _pascalsPerMmHg;

  /// Adds two pressure values together.
  Pressure operator +(Pressure other) =>
      Pressure._(_millimetersOfMercury + other._millimetersOfMercury);

  /// Subtracts one pressure value from another.
  Pressure operator -(Pressure other) =>
      Pressure._(_millimetersOfMercury - other._millimetersOfMercury);

  /// Returns true if this pressure is greater than [other].
  bool operator >(Pressure other) =>
      _millimetersOfMercury > other._millimetersOfMercury;

  /// Returns true if this pressure is less than [other].
  bool operator <(Pressure other) =>
      _millimetersOfMercury < other._millimetersOfMercury;

  /// Returns true if this pressure is greater than or equal to [other].
  bool operator >=(Pressure other) =>
      _millimetersOfMercury >= other._millimetersOfMercury;

  /// Returns true if this pressure is less than or equal to [other].
  bool operator <=(Pressure other) =>
      _millimetersOfMercury <= other._millimetersOfMercury;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pressure &&
          runtimeType == other.runtimeType &&
          (_millimetersOfMercury - other._millimetersOfMercury).abs() <
              _tolerance;

  @override
  int get hashCode => (_millimetersOfMercury / _tolerance).round().hashCode;

  @override
  int compareTo(Pressure other) =>
      _millimetersOfMercury.compareTo(other._millimetersOfMercury);

  @override
  String toString() => '${_millimetersOfMercury.toStringAsFixed(1)} mmHg';
}
