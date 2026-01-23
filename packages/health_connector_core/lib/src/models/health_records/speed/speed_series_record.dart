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
final class SpeedSeriesRecord extends SeriesHealthRecord<SpeedSample> {
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
  SpeedSeriesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [SpeedSeriesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [SpeedSeriesRecord] constructor, which enforces validation.
  @internalUse
  factory SpeedSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<SpeedSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SpeedSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  SpeedSeriesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) : super._();

  /// The average speed across all samples.
  Velocity get avgSpeed {
    if (samples.isEmpty) {
      return Velocity.zero;
    }
    if (samples.length == 1) {
      return samples.first.speed;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.speed.inMetersPerSecond,
    );
    final averageMetersPerSecond = total / samples.length;

    return Velocity.metersPerSecond(averageMetersPerSecond);
  }

  /// The minimum speed value among all samples.
  Velocity get minSpeed {
    if (samples.isEmpty) {
      return Velocity.zero;
    }
    return samples
        .map((s) => s.speed)
        .reduce((a, b) => (a.inMetersPerSecond < b.inMetersPerSecond) ? a : b);
  }

  /// The maximum speed value among all samples.
  Velocity get maxSpeed {
    if (samples.isEmpty) {
      return Velocity.zero;
    }
    return samples
        .map((s) => s.speed)
        .reduce((a, b) => (a.inMetersPerSecond > b.inMetersPerSecond) ? a : b);
  }

  /// Creates a copy with the given fields replaced with the new values.
  SpeedSeriesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Metadata? metadata,
    List<SpeedSample>? samples,
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
          const ListEquality<SpeedSample>().equals(
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
      const ListEquality<SpeedSample>().hash(samples) ^
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
final class SpeedSample {
  /// Minimum valid speed in km/h (0.0 km/h).
  ///
  /// At rest.
  static const double minSpeedKmh = 0.0;

  /// Maximum valid speed in km/h (150.0 km/h).
  ///
  /// Extreme cycling speeds (e.g., downhill); allows for various sports
  /// activities.
  static const double maxSpeedKmh = 150.0;

  /// Creates a speed measurement.
  ///
  /// The [time] parameter specifies when the measurement was taken. The [speed]
  /// parameter indicates the velocity.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [speed] is outside the valid range of
  ///   [minSpeedKmh]-[maxSpeedKmh] km/h.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSpeedKmh] km/h)**: At rest.
  /// - **Maximum ([maxSpeedKmh] km/h / 93 mph)**: Extreme cycling speeds (e.g.,
  ///   downhill); allows for various sports activities.
  SpeedSample({
    required DateTime time,
    required this.speed,
  }) : time = time.toUtc() {
    final kmh = speed.inKilometersPerHour;
    require(
      condition: kmh >= minSpeedKmh && kmh <= maxSpeedKmh,
      value: speed,
      name: 'speed',
      message:
          'Speed must be between $minSpeedKmh-${maxSpeedKmh.toStringAsFixed(0)} km/h (0-93 mph). Got '
          '${kmh.toStringAsFixed(1)} km/h.',
    );
  }

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
      other is SpeedSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          speed == other.speed;

  @override
  int get hashCode => time.hashCode ^ speed.hashCode;
}
