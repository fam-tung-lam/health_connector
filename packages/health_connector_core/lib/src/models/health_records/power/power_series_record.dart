part of '../health_record.dart';

/// Represents a power measurement over a time interval.
///
/// Android Health Connect's PowerRecord is a series record containing multiple
/// power measurements measured at different points in time during the interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`PowerRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/PowerRecord)
/// - **iOS HealthKit**: Not supported. Use [CyclingPowerRecord]
///
/// ## Example
///
/// ```dart
/// final record = PowerSeriesRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   samples: [
///     PowerSample(
///       time: DateTime.now().subtract(Duration(minutes: 15)),
///       power: Power.watts(250.0),
///     ),
///     PowerSample(
///       time: DateTime.now(),
///       power: Power.watts(280.0),
///     ),
///   ],
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_1_0
@supportedOnHealthConnect
@immutable
final class PowerSeriesRecord extends SeriesHealthRecord<PowerSample> {
  /// Creates a power record with samples.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [samples]: The list contains timestamped power measurements.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const PowerSeriesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  PowerSeriesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Metadata? metadata,
    List<PowerSample>? samples,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PowerSeriesRecord(
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
      other is PowerSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          const ListEquality<PowerSample>().equals(
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

/// A single power measurement within a [PowerSeriesRecord].
///
/// Represents a power measurement at a specific point in time.
///
/// {@category Health Records}
@sinceV2_1_0
@supportedOnHealthConnect
@immutable
final class PowerSample {
  /// Creates a power measurement.
  ///
  /// The [time] parameter specifies when the measurement was taken. The [power]
  /// parameter indicates the power output.
  const PowerSample({
    required this.time,
    required this.power,
  });

  /// The time at which the power was measured, stored as a UTC instant.
  ///
  /// To interpret this value in the user's local (civil) time, use the zone
  /// offset information from the parent [PowerSeriesRecord].
  final DateTime time;

  /// The power measurement value.
  final Power power;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PowerSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          power == other.power;

  @override
  int get hashCode => time.hashCode ^ power.hashCode;
}
