part of 'measurement_unit.dart';

/// Represents a volume measurement with automatic unit conversion.
///
/// Volume is used for hydration tracking, blood volume, and other
/// volume-related health data.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class Volume extends MeasurementUnit implements Comparable<Volume> {
  const Volume._(this._liters);

  /// Creates a volume from a value in liters.
  ///
  /// ## Parameters
  ///
  /// - [value]: The volume value in liters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.liters(2);
  /// print(volume.inLiters); // 2.0
  /// ```
  const Volume.liters(double value) : _liters = value;

  /// Creates a volume from a value in milliliters.
  ///
  /// ## Parameters
  ///
  /// - [value]: The volume value in milliliters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.milliliters(2000);
  /// print(volume.inLiters); // 2.0
  /// ```
  const Volume.milliliters(double value)
    : _liters = value / _millilitersPerLiter;

  /// Creates a volume from a value in US fluid ounces.
  ///
  /// ## Parameters
  ///
  /// - [value]: The volume value in US fluid ounces.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.fluidOuncesUs(67.6);
  /// print(volume.inLiters); // ~2.0
  /// ```
  const Volume.fluidOuncesUs(double value)
    : _liters = value * _litersPerUsFluidOunce;

  /// Creates a volume from a value in Imperial fluid ounces.
  ///
  /// ## Parameters
  ///
  /// - [value]: The volume value in Imperial fluid ounces.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.fluidOuncesImp(70.4);
  /// print(volume.inLiters); // ~2.0
  /// ```
  const Volume.fluidOuncesImp(double value)
    : _liters = value * _litersPerImpFluidOunce;

  /// A volume of zero liters.
  static const Volume zero = Volume._(0.0);

  /// Tolerance for floating-point comparison (1 milliliter).
  static const double _tolerance = 0.001;

  /// Conversion factor from liters to milliliters.
  static const double _millilitersPerLiter = 1000;

  /// Conversion factor from US fluid ounces to liters.
  ///
  /// 1 fl oz US = 0.0295735 L
  static const double _litersPerUsFluidOunce = 0.0295735;

  /// Conversion factor from Imperial fluid ounces to liters.
  ///
  /// 1 fl oz imp = 0.0284131 L
  static const double _litersPerImpFluidOunce = 0.0284131;

  /// The volume value stored in liters (base unit).
  final double _liters;

  /// Returns the volume in liters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.milliliters(1500);
  /// print(volume.inLiters); // 1.5
  /// ```
  double get inLiters => _liters;

  /// Returns the volume in milliliters.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.liters(1.5);
  /// print(volume.inMilliliters); // 1500.0
  /// ```
  double get inMilliliters => _liters * _millilitersPerLiter;

  /// Returns the volume in US fluid ounces.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.liters(2.0);
  /// print(volume.inFluidOuncesUs); // ~67.6
  /// ```
  double get inFluidOuncesUs => _liters / _litersPerUsFluidOunce;

  /// Returns the volume in Imperial fluid ounces.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final volume = Volume.liters(2.0);
  /// print(volume.inFluidOuncesImp); // ~70.4
  /// ```
  double get inFluidOuncesImp => _liters / _litersPerImpFluidOunce;

  /// Adds two volumes together.
  Volume operator +(Volume other) => Volume._(_liters + other._liters);

  /// Subtracts one volume from another.
  Volume operator -(Volume other) => Volume._(_liters - other._liters);

  /// Returns true if this volume is greater than [other].
  bool operator >(Volume other) => _liters > other._liters;

  /// Returns true if this volume is less than [other].
  bool operator <(Volume other) => _liters < other._liters;

  /// Returns true if this volume is greater than or equal to [other].
  bool operator >=(Volume other) => _liters >= other._liters;

  /// Returns true if this volume is less than or equal to [other].
  bool operator <=(Volume other) => _liters <= other._liters;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Volume &&
          runtimeType == other.runtimeType &&
          (_liters - other._liters).abs() < _tolerance;

  @override
  int get hashCode => (_liters / _tolerance).round().hashCode;

  @override
  int compareTo(Volume other) => _liters.compareTo(other._liters);

  @override
  String toString() => '${_liters.toStringAsFixed(3)} L';
}
