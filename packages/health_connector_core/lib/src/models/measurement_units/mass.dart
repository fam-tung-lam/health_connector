part of 'measurement_unit.dart';

/// Represents a mass measurement with automatic unit conversion.
///
/// Mass is used for body weight, body composition measurements, and
/// other mass-related health data.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Mass extends MeasurementUnit implements Comparable<Mass> {
  const Mass._(this._kilograms);

  /// Creates a mass from a value in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.kilograms(70.5);
  /// print(mass.inKilograms); // 70.5
  /// ```
  const Mass.kilograms(double value) : _kilograms = value;

  /// Creates a mass from a value in grams.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.grams(70500);
  /// print(mass.inKilograms); // 70.5
  /// ```
  const Mass.grams(double value) : _kilograms = value / _gramsPerKilogram;

  /// Creates a mass from a value in pounds.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.pounds(155.4);
  /// print(mass.inKilograms); // ~70.5
  /// ```
  const Mass.pounds(double value) : _kilograms = value * _kilogramsPerPound;

  /// Creates a mass from a value in ounces.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.ounces(2487.0);
  /// print(mass.inKilograms); // ~70.5
  /// ```
  const Mass.ounces(double value) : _kilograms = value * _kilogramsPerOunce;

  /// A mass of zero kilograms.
  static const Mass zero = Mass._(0.0);

  /// Medical-grade tolerance for floating-point comparison (10 grams).
  static const double _tolerance = 0.01;

  /// Conversion factor from kilograms to grams.
  static const double _gramsPerKilogram = 1000;

  /// Conversion factor from pounds to kilograms.
  ///
  /// 1 pound = 0.45359237 kg
  static const double _kilogramsPerPound = 0.45359237;

  /// Conversion factor from ounces to kilograms.
  ///
  /// 1 ounce = 0.028349523125 kg
  static const double _kilogramsPerOunce = 0.028349523125;

  /// The mass value stored in kilograms (base unit).
  final double _kilograms;

  /// Returns the mass in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.pounds(155.4);
  /// print(mass.inKilograms); // ~70.5
  /// ```
  double get inKilograms => _kilograms;

  /// Returns the mass in grams.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.kilograms(70.5);
  /// print(mass.inGrams); // 70500.0
  /// ```
  double get inGrams => _kilograms * _gramsPerKilogram;

  /// Returns the mass in pounds.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.kilograms(70.5);
  /// print(mass.inPounds); // ~155.42
  /// ```
  double get inPounds => _kilograms / _kilogramsPerPound;

  /// Returns the mass in ounces.
  ///
  /// Example:
  /// ```dart
  /// final mass = Mass.kilograms(70.5);
  /// print(mass.inOunces); // ~2487.0
  /// ```
  double get inOunces => _kilograms / _kilogramsPerOunce;

  /// Adds two masses together.
  ///
  /// Example:
  /// ```dart
  /// final m1 = Mass.kilograms(50.0);
  /// final m2 = Mass.kilograms(20.5);
  /// final total = m1 + m2;
  /// print(total.inKilograms); // 70.5
  /// ```
  Mass operator +(Mass other) => Mass._(_kilograms + other._kilograms);

  /// Subtracts one mass from another.
  ///
  /// Example:
  /// ```dart
  /// final m1 = Mass.kilograms(70.5);
  /// final m2 = Mass.kilograms(20.0);
  /// final diff = m1 - m2;
  /// print(diff.inKilograms); // 50.5
  /// ```
  Mass operator -(Mass other) => Mass._(_kilograms - other._kilograms);

  /// Returns true if this mass is greater than [other].
  bool operator >(Mass other) => _kilograms > other._kilograms;

  /// Returns true if this mass is less than [other].
  bool operator <(Mass other) => _kilograms < other._kilograms;

  /// Returns true if this mass is greater than or equal to [other].
  bool operator >=(Mass other) => _kilograms >= other._kilograms;

  /// Returns true if this mass is less than or equal to [other].
  bool operator <=(Mass other) => _kilograms <= other._kilograms;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          (_kilograms - other._kilograms).abs() < _tolerance;

  @override
  int get hashCode => (_kilograms / _tolerance).round().hashCode;

  @override
  int compareTo(Mass other) => _kilograms.compareTo(other._kilograms);

  @override
  String toString() => '${_kilograms.toStringAsFixed(3)} kg';
}
