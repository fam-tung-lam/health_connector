part of 'health_record.dart';

/// A health record that spans a duration of time.
///
/// ### iOS HealthKit Note
///
/// On iOS/HealthKit, this value will always be the same as
/// [endZoneOffsetSeconds]
/// because HealthKit only provides one metadata key (`HKMetadataKeyTimeZone`)
/// to store timezone info. This means that even if an interval spans a
/// timezone change, both values will reflect the same timezone offset.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class IntervalHealthRecord extends HealthRecord {
  /// Constructor for subclasses.
  const IntervalHealthRecord({
    required this.startTime,
    required this.endTime,
    required super.metadata,
    super.id,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// The start time of the interval.
  ///
  /// This is when the measurement or activity began.
  ///
  /// For activities like steps or distance, this is when the tracking period
  /// started. For exercise sessions, this is when the workout began.
  final DateTime startTime;

  /// The end time of the interval.
  ///
  /// This is when the measurement or activity ended.
  ///
  /// Must be after [startTime].
  final DateTime endTime;

  /// The timezone offset in seconds at the start of the interval.
  ///
  /// This represents the offset from UTC at [startTime]:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  final int? startZoneOffsetSeconds;

  /// The timezone offset in seconds at the end of the interval.
  ///
  /// This represents the offset from UTC at [endTime]:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  ///
  /// This can differ from [startZoneOffsetSeconds] if the interval spans a
  /// timezone change, such as:
  /// - Daylight saving time transition
  /// - Travel across timezones
  final int? endZoneOffsetSeconds;

  /// The duration of the interval.
  ///
  /// This is automatically computed as the difference between [endTime] and
  /// [startTime].
  Duration get duration => endTime.difference(startTime);
}
