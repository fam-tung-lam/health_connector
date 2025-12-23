part of 'measurement_unit.dart';

/// Represents a duration measurement with automatic unit conversion.
///
/// TimeDuration is used for duration measurements like sleep time,
/// exercise duration, and other time-based health data.
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
final class TimeDuration extends MeasurementUnit
    implements Comparable<TimeDuration> {
  const TimeDuration._(this._seconds);

  /// Creates an duration from a Duration object.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.fromDuration(Duration(hours: 8));
  /// print(duration.inHours); // 8.0
  /// ```
  TimeDuration.fromDuration(Duration duration)
    : _seconds = duration.inMicroseconds / Duration.microsecondsPerSecond;

  /// Creates an duration from a value in seconds.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.seconds(3600);
  /// print(duration.inHours); // 1.0
  /// ```
  const TimeDuration.seconds(double value) : _seconds = value;

  /// Creates an duration from a value in minutes.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.minutes(60);
  /// print(duration.inHours); // 1.0
  /// ```
  const TimeDuration.minutes(double value)
    : _seconds = value * _secondsPerMinute;

  /// Creates an duration from a value in hours.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.hours(8);
  /// print(duration.inMinutes); // 480.0
  /// ```
  const TimeDuration.hours(double value) : _seconds = value * _secondsPerHour;

  /// An duration of zero duration.
  static const TimeDuration zero = TimeDuration._(0.0);

  /// Tolerance for floating-point comparison (1 millisecond).
  static const double _tolerance = 0.001;

  /// Conversion factor from minutes to seconds.
  static const double _secondsPerMinute = 60.0;

  /// Conversion factor from hours to seconds.
  static const double _secondsPerHour = 3600.0;

  /// The duration value stored in seconds (base unit).
  final double _seconds;

  /// Returns the duration in seconds.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.hours(1);
  /// print(duration.inSeconds); // 3600.0
  /// ```
  double get inSeconds => _seconds;

  /// Returns the duration in minutes.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.hours(1);
  /// print(duration.inMinutes); // 60.0
  /// ```
  double get inMinutes => _seconds / _secondsPerMinute;

  /// Returns the duration in hours.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.minutes(120);
  /// print(duration.inHours); // 2.0
  /// ```
  double get inHours => _seconds / _secondsPerHour;

  /// Returns the duration as a Dart Duration object.
  ///
  /// Note: Converts to microseconds precision.
  ///
  /// Example:
  /// ```dart
  /// final duration = TimeDuration.hours(8);
  /// final duration = duration.asDuration;
  /// print(duration.inHours); // 8
  /// ```
  Duration toDuration() => Duration(
    microseconds: (_seconds * Duration.microsecondsPerSecond).round(),
  );

  /// Adds two intervals together.
  ///
  /// Example:
  /// ```dart
  /// final i1 = TimeDuration.hours(2);
  /// final i2 = TimeDuration.minutes(30);
  /// final total = i1 + i2;
  /// print(total.inHours); // 2.5
  /// ```
  TimeDuration operator +(TimeDuration other) =>
      TimeDuration._(_seconds + other._seconds);

  /// Subtracts one duration from another.
  ///
  /// Example:
  /// ```dart
  /// final i1 = TimeDuration.hours(3);
  /// final i2 = TimeDuration.minutes(30);
  /// final diff = i1 - i2;
  /// print(diff.inHours); // 2.5
  /// ```
  TimeDuration operator -(TimeDuration other) =>
      TimeDuration._(_seconds - other._seconds);

  /// Returns true if this duration is greater than [other].
  bool operator >(TimeDuration other) => _seconds > other._seconds;

  /// Returns true if this duration is less than [other].
  bool operator <(TimeDuration other) => _seconds < other._seconds;

  /// Returns true if this duration is greater than or equal to [other].
  bool operator >=(TimeDuration other) => _seconds >= other._seconds;

  /// Returns true if this duration is less than or equal to [other].
  bool operator <=(TimeDuration other) => _seconds <= other._seconds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeDuration &&
          runtimeType == other.runtimeType &&
          (_seconds - other._seconds).abs() < _tolerance;

  @override
  int get hashCode => (_seconds / _tolerance).round().hashCode;

  @override
  int compareTo(TimeDuration other) => _seconds.compareTo(other._seconds);

  @override
  String toString() => '${_seconds.toStringAsFixed(3)} s';
}
