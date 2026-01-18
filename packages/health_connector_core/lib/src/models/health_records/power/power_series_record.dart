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
  PowerSeriesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [PowerSeriesRecord] instances
  /// without validation.
  ///
  /// Creates a [PowerSeriesRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [PowerSeriesRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory PowerSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<PowerSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PowerSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  PowerSeriesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) : super._();

  /// The average power across all samples.
  Power get avgPower {
    if (samples.isEmpty) {
      return Power.zero;
    }
    if (samples.length == 1) {
      return samples.first.power;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.power.inWatts,
    );
    final averageWatts = total / samples.length;

    return Power.watts(averageWatts);
  }

  /// The minimum power value among all samples.
  Power get minPower {
    if (samples.isEmpty) {
      return Power.zero;
    }
    return samples
        .map((s) => s.power)
        .reduce((a, b) => (a.inWatts < b.inWatts) ? a : b);
  }

  /// The maximum power value among all samples.
  Power get maxPower {
    if (samples.isEmpty) {
      return Power.zero;
    }
    return samples
        .map((s) => s.power)
        .reduce((a, b) => (a.inWatts > b.inWatts) ? a : b);
  }

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
      const ListEquality<PowerSample>().hash(samples) ^
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
  /// Minimum valid power.
  static const Power minPower = CyclingPowerRecord.minPower;

  /// Maximum valid power.
  static const Power maxPower = CyclingPowerRecord.maxPower;

  /// Creates a power measurement.
  ///
  /// The [time] parameter specifies when the measurement was taken. The [power]
  /// parameter indicates the power output.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [power] is outside the valid range of
  ///   [minPower]-[maxPower] W.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minPower] W)**: No power output (coasting).
  /// - **Maximum ([maxPower] W)**: Elite track sprinters can peak at
  ///   ~2,500W; 3,000W provides margin for brief maximal efforts.
  PowerSample({
    required this.time,
    required this.power,
  }) {
    require(
      condition: power >= minPower && power <= maxPower,
      value: power,
      name: 'power',
      message:
          'Power must be between '
          '${minPower.inWatts.toStringAsFixed(0)}-'
          '${maxPower.inWatts.toStringAsFixed(0)} W. '
          'Got ${power.inWatts.toStringAsFixed(0)} W.',
    );
  }

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
