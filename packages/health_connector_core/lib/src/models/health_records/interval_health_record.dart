part of 'health_record.dart';

/// Base health record class that spans a duration of time.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class IntervalHealthRecord extends HealthRecord {
  /// Creates an [IntervalHealthRecord] from [startTime] to [endTime].
  ///
  /// Both [startTime] and [endTime] are converted to UTC for storage.
  ///
  /// The [startZoneOffsetSeconds] and [endZoneOffsetSeconds] are optional. If
  /// not provided, the timezone offset is inferred from [startTime] and
  /// [endTime]. If the [DateTime] is already in UTC, the timezone
  /// offset is not inferred.
  IntervalHealthRecord({
    required DateTime startTime,
    required DateTime endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) : startZoneOffsetSeconds =
           startZoneOffsetSeconds ?? _inferZoneOffsetSeconds(startTime),
       endZoneOffsetSeconds =
           endZoneOffsetSeconds ?? _inferZoneOffsetSeconds(endTime),
       startTime = startTime.toUtc(),
       endTime = endTime.toUtc() {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// The start time of the interval, stored as a UTC instant.
  ///
  /// This is when the measurement or activity began. To interpret this value
  /// in the user's local (civil) time, use [startZoneOffsetSeconds] if
  /// available.
  final DateTime startTime;

  /// The end time of the interval, stored as a UTC instant.
  ///
  /// This is when the measurement or activity ended. To interpret this value
  /// in the user's local (civil) time, use [endZoneOffsetSeconds] if available.
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

  /// Infers the timezone offset in seconds from a [DateTime].
  ///
  /// If the [dateTime] is in UTC, returns `null`. Otherwise, returns the
  /// [DateTime.timeZoneOffset] in seconds.
  ///
  /// This is used during construction to automatically capture the local
  /// timezone offset if it wasn't explicitly provided, provided the [DateTime]
  /// wasn't already converted to UTC.
  static int? _inferZoneOffsetSeconds(DateTime dateTime) {
    if (dateTime.isUtc) {
      return null;
    }

    return dateTime.timeZoneOffset.inSeconds;
  }
}
