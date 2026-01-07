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
///     HeartRateMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       beatsPerMinute: Frequency.perMinute(65),
///     ),
///     HeartRateMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       beatsPerMinute: Frequency.perMinute(120),
///     ),
///     HeartRateMeasurement(
///       time: DateTime.now(),
///       beatsPerMinute: Frequency.perMinute(80),
///     ),
///   ],
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateSeriesRecordHealthDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class HeartRateSeriesRecord
    extends SeriesHealthRecord<HeartRateMeasurement> {
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
  Frequency get averageBpm {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    if (samples.length == 1) {
      return samples.first.beatsPerMinute;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.beatsPerMinute.inPerMinute,
    );
    final averageBpmPerMin = total / samples.length;

    return Frequency.perMinute(averageBpmPerMin);
  }

  /// The minimum heart rate value among all samples.
  Frequency get minBpm {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.beatsPerMinute)
        .reduce((a, b) => (a.inPerMinute < b.inPerMinute) ? a : b);
  }

  /// The maximum heart rate value among all samples.
  Frequency get maxBpm {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.beatsPerMinute)
        .reduce((a, b) => (a.inPerMinute > b.inPerMinute) ? a : b);
  }

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<HeartRateMeasurement>? samples,
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
          _listEquals(samples, other.samples);

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) {
      return true;
    }
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

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
final class HeartRateMeasurement {
  /// Creates a heart rate measurement.
  const HeartRateMeasurement({
    required this.time,
    required this.beatsPerMinute,
  });

  /// The timestamp when this heart rate measurement was taken, stored as a
  /// UTC instant.
  ///
  /// Timezone offset information is provided by the parent record.
  final DateTime time;

  /// The heart rate value in beats per minute (BPM).
  final Frequency beatsPerMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateMeasurement &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          beatsPerMinute == other.beatsPerMinute;

  @override
  int get hashCode => time.hashCode ^ beatsPerMinute.hashCode;
}
