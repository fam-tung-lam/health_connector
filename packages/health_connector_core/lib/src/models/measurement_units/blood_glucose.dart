part of 'measurement_unit.dart';

/// Represents a blood glucose measurement with automatic unit conversion.
///
/// Blood glucose is used for diabetes management and glucose monitoring.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class BloodGlucose extends MeasurementUnit
    implements Comparable<BloodGlucose> {
  const BloodGlucose._(this._millimolesPerLiter);

  /// Creates a blood glucose measurement from millimoles per liter.
  ///
  /// This is the standard unit used in most countries.
  ///
  /// ## Parameters
  ///
  /// - [value]: The blood glucose value in millimoles per liter.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final glucose = BloodGlucose.millimolesPerLiter(5.5);
  /// print(glucose.inMillimolesPerLiter); // 5.5
  /// ```
  const BloodGlucose.millimolesPerLiter(double value)
    : _millimolesPerLiter = value;

  /// Creates a blood glucose measurement from milligrams per deciliter.
  ///
  /// This unit is primarily used in the United States.
  ///
  /// ## Parameters
  ///
  /// - [value]: The blood glucose value in milligrams per deciliter.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final glucose = BloodGlucose.milligramsPerDeciliter(99);
  /// print(glucose.inMillimolesPerLiter); // ~5.5
  /// ```
  const BloodGlucose.milligramsPerDeciliter(double value)
    : _millimolesPerLiter = value / _mmolToMgdlConversionFactor;

  /// A blood glucose of zero millimoles per liter.
  static const BloodGlucose zero = BloodGlucose._(0.0);

  /// Tolerance for floating-point comparison (0.01 mmol/L).
  static const double _tolerance = 0.01;

  /// Conversion factor from mmol/L to mg/dL.
  ///
  /// mg/dL = mmol/L × 18.0182
  static const double _mmolToMgdlConversionFactor = 18.0182;

  /// The blood glucose value stored in millimoles per liter (base unit).
  final double _millimolesPerLiter;

  /// Returns the blood glucose in millimoles per liter.
  ///
  /// This is the standard unit used in most countries.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final glucose = BloodGlucose.milligramsPerDeciliter(99);
  /// print(glucose.inMillimolesPerLiter); // ~5.5
  /// ```
  double get inMillimolesPerLiter => _millimolesPerLiter;

  /// Returns the blood glucose in milligrams per deciliter.
  ///
  /// This unit is primarily used in the United States.
  ///
  /// Conversion: mg/dL = mmol/L × 18.0182
  ///
  /// ## Example
  ///
  /// ```dart
  /// final glucose = BloodGlucose.millimolesPerLiter(5.5);
  /// print(glucose.inMilligramsPerDeciliter); // ~99.1
  /// ```
  double get inMilligramsPerDeciliter =>
      _millimolesPerLiter * _mmolToMgdlConversionFactor;

  /// Adds two blood glucose values together.
  BloodGlucose operator +(BloodGlucose other) =>
      BloodGlucose._(_millimolesPerLiter + other._millimolesPerLiter);

  /// Subtracts one blood glucose value from another.
  BloodGlucose operator -(BloodGlucose other) =>
      BloodGlucose._(_millimolesPerLiter - other._millimolesPerLiter);

  /// Returns true if this blood glucose is greater than [other].
  bool operator >(BloodGlucose other) =>
      _millimolesPerLiter > other._millimolesPerLiter;

  /// Returns true if this blood glucose is less than [other].
  bool operator <(BloodGlucose other) =>
      _millimolesPerLiter < other._millimolesPerLiter;

  /// Returns true if this blood glucose is greater than or equal to [other].
  bool operator >=(BloodGlucose other) =>
      _millimolesPerLiter >= other._millimolesPerLiter;

  /// Returns true if this blood glucose is less than or equal to [other].
  bool operator <=(BloodGlucose other) =>
      _millimolesPerLiter <= other._millimolesPerLiter;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucose &&
          runtimeType == other.runtimeType &&
          (_millimolesPerLiter - other._millimolesPerLiter).abs() < _tolerance;

  @override
  int get hashCode => (_millimolesPerLiter / _tolerance).round().hashCode;

  @override
  int compareTo(BloodGlucose other) =>
      _millimolesPerLiter.compareTo(other._millimolesPerLiter);

  @override
  String toString() => '${_millimolesPerLiter.toStringAsFixed(2)} mmol/L';
}
