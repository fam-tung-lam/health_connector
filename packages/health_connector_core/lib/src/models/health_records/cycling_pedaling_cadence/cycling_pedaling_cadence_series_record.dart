part of '../health_record.dart';

/// Represents a series of cycling pedaling cadence measurements over a
/// time interval.
///
/// A cycling pedaling cadence series record is a container with a time
/// range and multiple RPM measurements taken during that period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**:
///   [`CyclingPedalingCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord)
/// - **iOS HealthKit**: Not supported
///   (Use [CyclingPedalingCadenceMeasurementRecord])
///
/// ## Example
///
/// ```dart
/// final record = CyclingPedalingCadenceSeriesRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   samples: [
///     CyclingPedalingCadenceMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       revolutionsPerMinute: Number(60),
///     ),
///     CyclingPedalingCadenceMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       revolutionsPerMinute: Number(90),
///     ),
///     CyclingPedalingCadenceMeasurement(
///       time: DateTime.now(),
///       revolutionsPerMinute: Number(75),
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
/// - [CyclingPedalingCadenceSeriesRecordHealthDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class CyclingPedalingCadenceSeriesRecord
    extends SeriesHealthRecord<CyclingPedalingCadenceMeasurement> {
  /// Creates a cycling pedaling cadence series record.
  const CyclingPedalingCadenceSeriesRecord({
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The average cadence across all samples.
  Number get averageRpm {
    if (samples.isEmpty) {
      return Number.zero;
    }
    if (samples.length == 1) {
      return samples.first.revolutionsPerMinute;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.revolutionsPerMinute.value,
    );
    final averageRpmValue = (total / samples.length).toInt();

    return Number(averageRpmValue);
  }

  /// The minimum cadence value among all samples.
  Number get minRpm {
    if (samples.isEmpty) {
      return Number.zero;
    }
    return samples
        .map((s) => s.revolutionsPerMinute)
        .reduce((a, b) => (a.value < b.value) ? a : b);
  }

  /// The maximum cadence value among all samples.
  Number get maxRpm {
    if (samples.isEmpty) {
      return Number.zero;
    }
    return samples
        .map((s) => s.revolutionsPerMinute)
        .reduce((a, b) => (a.value > b.value) ? a : b);
  }

  /// Creates a copy with the given fields replaced with the new values.
  CyclingPedalingCadenceSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<CyclingPedalingCadenceMeasurement>? samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceSeriesRecord(
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
      other is CyclingPedalingCadenceSeriesRecord &&
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
