part of 'measurement_unit.dart';

/// Represents a frequency measurement with automatic unit conversion.
///
/// Frequency is used for heart rate, respiratory rate, and other
/// rate-based measurements.
///
/// {@category Measurement Units}
@sinceV3_0_0
@immutable
final class Frequency extends MeasurementUnit implements Comparable<Frequency> {
  const Frequency._(this._perMinute);

  /// Creates a frequency from events per minute.
  ///
  /// ## Parameters
  ///
  /// - [value]: The frequency value in events per minute.
  ///   Must be a positive, finite number.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [value] is not a positive, finite number.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final heartRate = Frequency.perMinute(72);
  /// print(heartRate.inPerMinute); // 72.0
  /// ```
  factory Frequency.perMinute(double value) {
    _validate(value);
    return Frequency._(value);
  }

  /// Creates a frequency from events per second.
  ///
  /// ## Parameters
  ///
  /// - [value]: The frequency value in events per second.
  ///   Must be a positive, finite number.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [value] is not a positive, finite number.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final frequency = Frequency.perSecond(1.2);
  /// print(frequency.inPerMinute); // 72.0
  /// ```
  factory Frequency.perSecond(double value) {
    _validate(value);
    return Frequency._(value * 60);
  }

  /// Validate a frequency from events per second.
  ///
  /// ## Parameters
  ///
  /// - [value]: The frequency value in events per second.
  ///   Must be a positive, finite number.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [value] is not a positive, finite number.
  static void _validate(double value) {
    if (value.isNaN) {
      throw ArgumentError.value(value, 'value', 'Frequency cannot be NaN');
    }
    if (value.isInfinite) {
      throw ArgumentError.value(
        value,
        'value',
        'Frequency cannot be infinite',
      );
    }
    if (value < 0) {
      throw ArgumentError.value(
        value,
        'value',
        'Frequency must be non-negative',
      );
    }
  }

  /// A frequency of zero events per minute.
  static const Frequency zero = Frequency._(0.0);

  /// Tolerance for floating-point comparison (0.1 events/minute).
  static const double _tolerance = 0.1;

  /// The frequency value stored in events per minute (base unit).
  final double _perMinute;

  /// Returns frequency in events per minute (primary clinical unit for HR/RR).
  ///
  /// ## Example
  ///
  /// ```dart
  /// final heartRate = Frequency.perSecond(1.2);
  /// print(heartRate.inPerMinute); // 72.0
  /// ```
  double get inPerMinute => _perMinute;

  /// Returns frequency in events per second (for technical applications).
  ///
  /// ## Example
  ///
  /// ```dart
  /// final heartRate = Frequency.perMinute(72);
  /// print(heartRate.inPerSecond); // 1.2
  /// ```
  double get inPerSecond => _perMinute / 60;

  /// Returns frequency in hertz (events/s, for compatibility with physical units).
  ///
  /// This is an alias for [inPerSecond].
  ///
  /// ## Example
  ///
  /// ```dart
  /// final heartRate = Frequency.perMinute(72);
  /// print(heartRate.inHertz); // 1.2
  /// ```
  double get inHertz => inPerSecond;

  /// Adds two frequencies together.
  Frequency operator +(Frequency other) =>
      Frequency._(_perMinute + other._perMinute);

  /// Subtracts one frequency from another.
  Frequency operator -(Frequency other) =>
      Frequency._(_perMinute - other._perMinute);

  /// Returns true if this frequency is greater than [other].
  bool operator >(Frequency other) => _perMinute > other._perMinute;

  /// Returns true if this frequency is less than [other].
  bool operator <(Frequency other) => _perMinute < other._perMinute;

  /// Returns true if this frequency is greater than or equal to [other].
  bool operator >=(Frequency other) => _perMinute >= other._perMinute;

  /// Returns true if this frequency is less than or equal to [other].
  bool operator <=(Frequency other) => _perMinute <= other._perMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Frequency &&
          runtimeType == other.runtimeType &&
          (_perMinute - other._perMinute).abs() < _tolerance;

  @override
  int get hashCode => (_perMinute / _tolerance).round().hashCode;

  @override
  int compareTo(Frequency other) => _perMinute.compareTo(other._perMinute);

  @override
  String toString() => '${_perMinute.toStringAsFixed(1)} per min';
}
