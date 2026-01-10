part of 'health_record.dart';

/// Base health record class that spans a duration of time.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class IntervalHealthRecord extends HealthRecord {
  /// Public constructor with validation.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  IntervalHealthRecord({
    required this.startTime,
    required this.endTime,
    required super.metadata,
    super.id,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// The start time of the interval, stored as a UTC instant.
  ///
  /// This is when the measurement or activity began. To interpret this value
  /// in the user's local (civil) time, use [startZoneOffsetSeconds] if
  /// available.
  ///
  /// Must be before [endTime].
  final DateTime startTime;

  /// The end time of the interval, stored as a UTC instant.
  ///
  /// This is when the measurement or activity ended. To interpret this value
  /// in the user's local (civil) time, use [endZoneOffsetSeconds] if available.
  ///
  /// Must be after [startTime].
  final DateTime endTime;

  /// The timezone offset in seconds at the start of the interval.
  ///
  /// This offset allows interpreting [startTime] in the user's local (civil)
  /// time zone at the moment of measurement:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  final int? startZoneOffsetSeconds;

  /// The timezone offset in seconds at the end of the interval.
  ///
  /// This offset allows interpreting [endTime] in the user's local (civil)
  /// time zone at the moment of measurement:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  ///
  /// **Note**: [endZoneOffsetSeconds] can differ from [startZoneOffsetSeconds]
  /// if the interval spans a timezone change, such as:
  /// - Daylight saving time transition
  /// - Travel across timezones
  final int? endZoneOffsetSeconds;

  /// The duration of the interval.
  ///
  /// This is automatically computed as the difference between [endTime] and
  /// [startTime].
  Duration get duration => endTime.difference(startTime);
}
