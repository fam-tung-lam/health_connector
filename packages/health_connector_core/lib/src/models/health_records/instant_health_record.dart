part of 'health_record.dart';

/// Base health record class representing a measurement at a single point
/// in time.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class InstantHealthRecord extends HealthRecord {
  /// Creates an instant health record at the specified [time].
  ///
  /// The [zoneOffsetSeconds] is optional and represents the timezone offset
  /// in seconds from UTC at the [time] of measurement.
  InstantHealthRecord({
    required DateTime time,
    required super.metadata,
    super.id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) : zoneOffsetSeconds =
           zoneOffsetSeconds ??
           IntervalHealthRecord._inferZoneOffsetSeconds(time),
       time = time.toUtc();

  /// The time when this measurement was taken, stored as a UTC instant.
  ///
  /// The timestamp is always stored in UTC. To interpret this value in the
  /// user's local (civil) time, use [zoneOffsetSeconds] if available.
  final DateTime time;

  /// The timezone offset in seconds at the time of measurement.
  ///
  /// This offset allows interpreting [time] in the user's local (civil) time
  /// zone at the moment of measurement:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  final int? zoneOffsetSeconds;
}
