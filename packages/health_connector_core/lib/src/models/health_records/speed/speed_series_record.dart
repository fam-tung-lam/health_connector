part of '../health_record.dart';

/// Represents a speed measurement over a time interval.
///
/// Android Health Connect's SpeedRecord is a series record containing multiple
/// speed measurements measured at different points in time during the interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SpeedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SpeedRecord)
/// - **iOS HealthKit**: Not supported. Use the activity-specific speed records:
///   - [WalkingSpeedRecord]
///   - [RunningSpeedRecord]
///   - [StairAscentSpeedRecord]
///   - [StairDescentSpeedRecord]
///
/// ## Example
///
/// ```dart
/// final record = SpeedRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   samples: [
///     SpeedSample(
///       time: DateTime.now().subtract(Duration(minutes: 15)),
///       speed: Velocity.metersPerSecond(2.5),
///     ),
///     SpeedSample(
///       time: DateTime.now(),
///       speed: Velocity.metersPerSecond(3.0),
///     ),
///   ],
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnHealthConnect
@immutable
final class SpeedSeriesRecord extends SeriesHealthRecord<SpeedMeasurement> {
  /// Creates a speed record with samples.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [samples]: The list contains timestamped speed measurements.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const SpeedSeriesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  SpeedSeriesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Metadata? metadata,
    List<SpeedMeasurement>? samples,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SpeedSeriesRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      metadata: metadata ?? this.metadata,
      samples: samples ?? this.samples,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          const ListEquality<SpeedMeasurement>().equals(
            samples,
            other.samples,
          ) &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      Object.hashAll(samples) ^
      metadata.hashCode;
}

/// A single speed measurement within a [SpeedSeriesRecord].
///
/// Represents a speed measurement at a specific point in time.
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnHealthConnect
@immutable
final class SpeedMeasurement {
  /// Creates a speed measurement.
  ///
  /// The [time] parameter specifies when the measurement was taken. The [speed]
  /// parameter indicates the velocity.
  const SpeedMeasurement({
    required this.time,
    required this.speed,
  });

  /// The time at which the speed was measured, stored as a UTC instant.
  ///
  /// To interpret this value in the user's local (civil) time, use the zone
  /// offset information from the parent [SpeedSeriesRecord].
  final DateTime time;

  /// The speed measurement value.
  final Velocity speed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedMeasurement &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          speed == other.speed;

  @override
  int get hashCode => time.hashCode ^ speed.hashCode;
}
