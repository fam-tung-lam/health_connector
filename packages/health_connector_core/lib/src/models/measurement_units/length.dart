part of 'measurement_unit.dart';

/// Represents a length measurement with automatic unit conversion.
///
/// Length is used for distance traveled, height, and
/// other length-related health data.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class Length extends MeasurementUnit implements Comparable<Length> {
  const Length._(this._meters);

  /// Creates a length from a value in meters.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in meters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(1000);
  /// print(length.inMeters); // 1000.0
  /// ```
  const Length.meters(double value) : _meters = value;

  /// Creates a length from a value in kilometers.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in kilometers.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.kilometers(1);
  /// print(length.inMeters); // 1000.0
  /// ```
  const Length.kilometers(double value) : _meters = value * _metersPerKilometer;

  /// Creates a length from a value in centimeters.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in centimeters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.centimeters(100000);
  /// print(length.inMeters); // 1000.0
  /// ```
  const Length.centimeters(double value)
    : _meters = value / _centimetersPerMeter;

  /// Creates a length from a value in millimeters.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in millimeters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.millimeters(1000000);
  /// print(length.inMeters); // 1000.0
  /// ```
  const Length.millimeters(double value)
    : _meters = value / _metersPerKilometer;

  /// Creates a length from a value in miles.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in miles.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.miles(0.621371);
  /// print(length.inMeters); // ~1000.0
  /// ```
  const Length.miles(double value) : _meters = value * _metersPerMile;

  /// Creates a length from a value in feet.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in feet.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.feet(3280.84);
  /// print(length.inMeters); // ~1000.0
  /// ```
  const Length.feet(double value) : _meters = value * _metersPerFoot;

  /// Creates a length from a value in inches.
  ///
  /// ## Parameters
  ///
  /// - [value]: The length value in inches.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.inches(39370.1);
  /// print(length.inMeters); // ~1000.0
  /// ```
  const Length.inches(double value) : _meters = value * _metersPerInch;

  /// A length of zero meters.
  static const Length zero = Length._(0.0);

  /// Tolerance for floating-point comparison (1 millimeter).
  static const double _tolerance = 0.001;

  /// Conversion factor from meters to kilometers/millimeters.
  static const double _metersPerKilometer = 1000;

  /// Conversion factor from meters to centimeters.
  static const double _centimetersPerMeter = 100;

  /// Conversion factor from miles to meters.
  ///
  /// 1 mile = 1609.344 meters
  static const double _metersPerMile = 1609.344;

  /// Conversion factor from feet to meters.
  ///
  /// 1 foot = 0.3048 meters
  static const double _metersPerFoot = 0.3048;

  /// Conversion factor from inches to meters.
  ///
  /// 1 inch = 0.0254 meters
  static const double _metersPerInch = 0.0254;

  /// The length value stored in meters (base unit).
  final double _meters;

  /// Returns the length in meters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.kilometers(1.5);
  /// print(length.inMeters); // 1500.0
  /// ```
  double get inMeters => _meters;

  /// Returns the length in kilometers.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(1500);
  /// print(length.inKilometers); // 1.5
  /// ```
  double get inKilometers => _meters / _metersPerKilometer;

  /// Returns the length in centimeters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(1.5);
  /// print(length.inCentimeters); // 150.0
  /// ```
  double get inCentimeters => _meters * _centimetersPerMeter;

  /// Returns the length in millimeters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(0.05);
  /// print(length.inMillimeters); // 50.0
  /// ```
  double get inMillimeters => _meters * _metersPerKilometer;

  /// Returns the length in miles.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(1609.34);
  /// print(length.inMiles); // ~1.0
  /// ```
  double get inMiles => _meters / _metersPerMile;

  /// Returns the length in feet.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.meters(1);
  /// print(length.inFeet); // ~3.28
  /// ```
  double get inFeet => _meters / _metersPerFoot;

  /// Returns the length in inches.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final length = Length.feet(1);
  /// print(length.inInches); // 12.0
  /// ```
  double get inInches => _meters / _metersPerInch;

  /// Adds two lengths together.
  Length operator +(Length other) => Length._(_meters + other._meters);

  /// Subtracts one length from another.
  Length operator -(Length other) => Length._(_meters - other._meters);

  /// Returns true if this length is greater than [other].
  bool operator >(Length other) => _meters > other._meters;

  /// Returns true if this length is less than [other].
  bool operator <(Length other) => _meters < other._meters;

  /// Returns true if this length is greater than or equal to [other].
  bool operator >=(Length other) => _meters >= other._meters;

  /// Returns true if this length is less than or equal to [other].
  bool operator <=(Length other) => _meters <= other._meters;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Length &&
          runtimeType == other.runtimeType &&
          (_meters - other._meters).abs() < _tolerance;

  @override
  int get hashCode => (_meters / _tolerance).round().hashCode;

  @override
  int compareTo(Length other) => _meters.compareTo(other._meters);

  @override
  String toString() => '${_meters.toStringAsFixed(3)} m';
}
