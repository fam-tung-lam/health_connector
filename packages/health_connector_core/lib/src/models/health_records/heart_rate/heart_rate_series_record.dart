part of '../health_record.dart';

/// Represents a series of heart rate measurements over a time interval.
///
/// A heart rate series record is a container with a time range and multiple
/// BPM measurements taken during that period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateRecord)
/// - **iOS HealthKit**: Not supported (Use [HeartRateMeasurementRecord])
///
/// ## Example
///
/// ```dart
/// final record = HeartRateSeriesRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   samples: [
///     HeartRateSample(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       rate: Frequency.perMinute(65),
///     ),
///     HeartRateSample(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       rate: Frequency.perMinute(120),
///     ),
///     HeartRateSample(
///       time: DateTime.now(),
///       rate: Frequency.perMinute(80),
///     ),
///   ],
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateSeriesRecordDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class HeartRateSeriesRecord extends SeriesHealthRecord<HeartRateSample> {
  /// Creates a heart rate series record.
  const HeartRateSeriesRecord({
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The average heart rate across all samples.
  Frequency get averageRate {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    if (samples.length == 1) {
      return samples.first.rate;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.rate.inPerMinute,
    );
    final averageBpmPerMin = total / samples.length;

    return Frequency.perMinute(averageBpmPerMin);
  }

  /// The minimum heart rate value among all samples.
  Frequency get minRate {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.rate)
        .reduce((a, b) => (a.inPerMinute < b.inPerMinute) ? a : b);
  }

  /// The maximum heart rate value among all samples.
  Frequency get maxRate {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.rate)
        .reduce((a, b) => (a.inPerMinute > b.inPerMinute) ? a : b);
  }

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<HeartRateSample>? samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartRateSeriesRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      samples: samples ?? this.samples,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          const ListEquality<HeartRateSample>().equals(
            samples,
            other.samples,
          );

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      Object.hashAll(samples);
}

/// Represents a single heart rate measurement at a specific point in time.
///
/// This class is used exclusively as a sample type within
/// [HeartRateSeriesRecord] to represent individual BPM measurements in a
/// time series.
///
/// **Note**: This class does not have an ID or metadata. Those are
/// properties of the record that contains the measurement.
///
/// {@category Health Records}
@immutable
final class HeartRateSample {
  /// Creates a heart rate measurement.
  const HeartRateSample({
    required this.time,
    required this.rate,
  });

  /// The timestamp when this heart rate measurement was taken, stored as a
  /// UTC instant.
  ///
  /// Timezone offset information is provided by the parent record.
  final DateTime time;

  /// The heart rate value in beats per minute (BPM).
  final Frequency rate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          rate == other.rate;

  @override
  int get hashCode => time.hashCode ^ rate.hashCode;
}
