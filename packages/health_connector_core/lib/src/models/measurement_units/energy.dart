part of 'measurement_unit.dart';

/// Represents an energy measurement with automatic unit conversion.
///
/// Energy is used for calories burned, basal metabolic rate, and
/// other energy-related health data.
@sinceV1_0_0
@immutable
final class Energy extends MeasurementUnit implements Comparable<Energy> {
  const Energy._(this._kilocalories);

  /// Creates an energy value from kilocalories.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilocalories(2000);
  /// print(energy.inKilocalories); // 2000.0
  /// ```
  const Energy.kilocalories(double value) : _kilocalories = value;

  /// Creates an energy value from calories.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.calories(2000000);
  /// print(energy.inKilocalories); // 2000.0
  /// ```
  const Energy.calories(double value)
    : _kilocalories = value / _caloriesPerKilocalorie;

  /// Creates an energy value from kilojoules.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilojoules(8368);
  /// print(energy.inKilocalories); // ~2000.0
  /// ```
  const Energy.kilojoules(double value)
    : _kilocalories = value / _kilocaloriesToKilojoulesConversionFactor;

  /// Creates an energy value from joules.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.joules(8368000);
  /// print(energy.inKilocalories); // ~2000.0
  /// ```
  const Energy.joules(double value)
    : _kilocalories = value / _kilocaloriesToJoulesConversionFactor;

  /// An energy of zero kilocalories.
  static const Energy zero = Energy._(0.0);

  /// Tolerance for floating-point comparison (10 calories).
  static const double _tolerance = 0.01;

  /// Conversion factor from kilocalories to calories.
  static const double _caloriesPerKilocalorie = 1000;

  /// Conversion factor from kilocalories to kilojoules.
  ///
  /// 1 kcal = 4.184 kJ
  static const double _kilocaloriesToKilojoulesConversionFactor = 4.184;

  /// Conversion factor from kilocalories to joules.
  ///
  /// 1 kcal = 4184 J
  static const double _kilocaloriesToJoulesConversionFactor = 4184;

  /// The energy value stored in kilocalories (base unit).
  final double _kilocalories;

  /// Returns the energy in kilocalories.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilojoules(8368);
  /// print(energy.inKilocalories); // ~2000.0
  /// ```
  double get inKilocalories => _kilocalories;

  /// Returns the energy in calories.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilocalories(2000);
  /// print(energy.inCalories); // 2000000.0
  /// ```
  double get inCalories => _kilocalories * _caloriesPerKilocalorie;

  /// Returns the energy in kilojoules.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilocalories(2000);
  /// print(energy.inKilojoules); // ~8368.0
  /// ```
  double get inKilojoules =>
      _kilocalories * _kilocaloriesToKilojoulesConversionFactor;

  /// Returns the energy in joules.
  ///
  /// Example:
  /// ```dart
  /// final energy = Energy.kilocalories(2000);
  /// print(energy.inJoules); // ~8368000.0
  /// ```
  double get inJoules => _kilocalories * _kilocaloriesToJoulesConversionFactor;

  /// Adds two energy values together.
  ///
  /// Example:
  /// ```dart
  /// final e1 = Energy.kilocalories(1500);
  /// final e2 = Energy.kilocalories(500);
  /// final total = e1 + e2;
  /// print(total.inKilocalories); // 2000.0
  /// ```
  Energy operator +(Energy other) =>
      Energy._(_kilocalories + other._kilocalories);

  /// Subtracts one energy value from another.
  ///
  /// Example:
  /// ```dart
  /// final e1 = Energy.kilocalories(2000);
  /// final e2 = Energy.kilocalories(500);
  /// final diff = e1 - e2;
  /// print(diff.inKilocalories); // 1500.0
  /// ```
  Energy operator -(Energy other) =>
      Energy._(_kilocalories - other._kilocalories);

  /// Returns true if this energy is greater than [other].
  bool operator >(Energy other) => _kilocalories > other._kilocalories;

  /// Returns true if this energy is less than [other].
  bool operator <(Energy other) => _kilocalories < other._kilocalories;

  /// Returns true if this energy is greater than or equal to [other].
  bool operator >=(Energy other) => _kilocalories >= other._kilocalories;

  /// Returns true if this energy is less than or equal to [other].
  bool operator <=(Energy other) => _kilocalories <= other._kilocalories;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Energy &&
          runtimeType == other.runtimeType &&
          (_kilocalories - other._kilocalories).abs() < _tolerance;

  @override
  int get hashCode => (_kilocalories / _tolerance).round().hashCode;

  @override
  int compareTo(Energy other) => _kilocalories.compareTo(other._kilocalories);

  @override
  String get name => 'energy';

  @override
  String toString() => '${_kilocalories.toStringAsFixed(3)} kcal';
}
