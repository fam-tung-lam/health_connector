part of 'measurement_unit.dart';

/// Represents a temperature measurement with automatic unit conversion.
///
/// Temperature is used for body temperature and other
/// temperature-related health data.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Temperature extends MeasurementUnit
    implements Comparable<Temperature> {
  const Temperature._(this._celsius);

  /// Creates a temperature from a value in Celsius.
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.celsius(36.5);
  /// print(temp.inCelsius); // 36.5
  /// ```
  const Temperature.celsius(double value) : _celsius = value;

  /// Creates a temperature from a value in Fahrenheit.
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.fahrenheit(97.7);
  /// print(temp.inCelsius); // ~36.5
  /// ```
  const Temperature.fahrenheit(double value)
    : _celsius =
          (value - _fahrenheitOffset) *
          _fahrenheitConversionNumerator /
          _fahrenheitConversionDenominator;

  /// Creates a temperature from a value in Kelvin.
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.kelvin(309.65);
  /// print(temp.inCelsius); // ~36.5
  /// ```
  const Temperature.kelvin(double value) : _celsius = value - _kelvinOffset;

  /// A temperature of zero Celsius (freezing point of water).
  static const Temperature zero = Temperature._(0.0);

  /// Tolerance for floating-point comparison (0.01°C).
  static const double _tolerance = 0.01;

  /// Fahrenheit offset for conversion.
  ///
  /// °F = °C × 9/5 + 32
  static const double _fahrenheitOffset = 32;

  /// Fahrenheit to Celsius conversion numerator.
  static const double _fahrenheitConversionNumerator = 5;

  /// Fahrenheit to Celsius conversion denominator.
  static const double _fahrenheitConversionDenominator = 9;

  /// Kelvin offset for conversion.
  ///
  /// K = °C + 273.15
  static const double _kelvinOffset = 273.15;

  /// The temperature value stored in Celsius (base unit).
  final double _celsius;

  /// Returns the temperature in Celsius.
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.fahrenheit(98.6);
  /// print(temp.inCelsius); // 37.0
  /// ```
  double get inCelsius => _celsius;

  /// Returns the temperature in Fahrenheit.
  ///
  /// Formula: °F = °C × 9/5 + 32
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.celsius(37.0);
  /// print(temp.inFahrenheit); // 98.6
  /// ```
  double get inFahrenheit =>
      _celsius *
          _fahrenheitConversionDenominator /
          _fahrenheitConversionNumerator +
      _fahrenheitOffset;

  /// Returns the temperature in Kelvin.
  ///
  /// Formula: K = °C + 273.15
  ///
  /// Example:
  /// ```dart
  /// final temp = Temperature.celsius(0);
  /// print(temp.inKelvin); // 273.15
  /// ```
  double get inKelvin => _celsius + _kelvinOffset;

  /// Adds two temperature differences together.
  ///
  /// Note: Adding absolute temperatures doesn't make physical sense, but
  /// this is useful for temperature differences.
  Temperature operator +(Temperature other) =>
      Temperature._(_celsius + other._celsius);

  /// Subtracts one temperature from another (temperature difference).
  Temperature operator -(Temperature other) =>
      Temperature._(_celsius - other._celsius);

  /// Returns true if this temperature is greater than [other].
  bool operator >(Temperature other) => _celsius > other._celsius;

  /// Returns true if this temperature is less than [other].
  bool operator <(Temperature other) => _celsius < other._celsius;

  /// Returns true if this temperature is greater than or equal to [other].
  bool operator >=(Temperature other) => _celsius >= other._celsius;

  /// Returns true if this temperature is less than or equal to [other].
  bool operator <=(Temperature other) => _celsius <= other._celsius;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Temperature &&
          runtimeType == other.runtimeType &&
          (_celsius - other._celsius).abs() < _tolerance;

  @override
  int get hashCode => (_celsius / _tolerance).round().hashCode;

  @override
  int compareTo(Temperature other) => _celsius.compareTo(other._celsius);

  @override
  String toString() => '${_celsius.toStringAsFixed(2)} °C';
}
