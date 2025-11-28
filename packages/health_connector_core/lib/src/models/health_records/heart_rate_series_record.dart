part of 'health_record.dart';

/// Represents a series of heart rate measurements over a time interval
/// (Android).
///
/// **Platform:** Android only (Health Connect)
///
/// A heart rate series record is a container with a time range and multiple
/// BPM measurements taken during that period. This is commonly used for
/// continuous monitoring during exercise or medical tracking.
///
/// ## Example
/// ```dart
/// final record = HeartRateSeriesRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   samples: [
///     HeartRateMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       beatsPerMinute: Numeric(65),
///     ),
///     HeartRateMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       beatsPerMinute: Numeric(120),
///     ),
///     HeartRateMeasurement(
///       time: DateTime.now(),
///       beatsPerMinute: Numeric(80),
///     ),
///   ],
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class HeartRateSeriesRecord
    extends SeriesHealthRecord<HeartRateMeasurement> {
  const HeartRateSeriesRecord({
    required super.id,
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The average heart rate across all samples.
  Numeric get averageBpm {
    if (samples.isEmpty) {
      return Numeric.zero;
    }
    if (samples.length == 1) {
      return samples.first.beatsPerMinute;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.beatsPerMinute.value,
    );
    return Numeric(total / samples.length);
  }

  /// The minimum heart rate value among all samples.
  Numeric get minBpm {
    if (samples.isEmpty) {
      return Numeric.zero;
    }
    return samples
        .map((s) => s.beatsPerMinute)
        .reduce((a, b) => (a.value < b.value) ? a : b);
  }

  /// The maximum heart rate value among all samples.
  Numeric get maxBpm {
    if (samples.isEmpty) {
      return Numeric.zero;
    }
    return samples
        .map((s) => s.beatsPerMinute)
        .reduce((a, b) => (a.value > b.value) ? a : b);
  }

  @override
  String get name => 'heart_rate_series_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

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

  @override
  String toString() {
    return 'HeartRateSeriesRecord('
        'id: $id, '
        'startTime: $startTime, '
        'endTime: $endTime, '
        'samples: ${samples.length}, '
        'avgBpm: ${averageBpm.value}, '
        'metadata: $metadata'
        ')';
  }
}
