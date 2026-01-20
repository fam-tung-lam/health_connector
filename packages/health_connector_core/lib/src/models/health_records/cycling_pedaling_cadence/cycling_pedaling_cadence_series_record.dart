part of '../health_record.dart';

/// Represents a series of cycling pedaling cadence measurements over a
/// time interval.
///
/// A cycling pedaling cadence series record is a container with a time
/// range and multiple RPM measurements taken during that period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**:  [`CyclingPedalingCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord)
/// - **iOS HealthKit**: Not supported  (Use [CyclingPedalingCadenceRecord])
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
///       cadence: Number(60),
///     ),
///     CyclingPedalingCadenceMeasurement(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       cadence: Number(90),
///     ),
///     CyclingPedalingCadenceMeasurement(
///       time: DateTime.now(),
///       cadence: Number(75),
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
/// - [CyclingPedalingCadenceSeriesDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class CyclingPedalingCadenceSeriesRecord
    extends SeriesHealthRecord<CyclingPedalingCadenceSample> {
  /// Creates a cycling pedaling cadence series record.
  CyclingPedalingCadenceSeriesRecord({
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating
  /// [CyclingPedalingCadenceSeriesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [CyclingPedalingCadenceSeriesRecord] constructor, which enforces
  /// validation.
  @internalUse
  factory CyclingPedalingCadenceSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<CyclingPedalingCadenceSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  CyclingPedalingCadenceSeriesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) : super._();

  /// The average cadence across all samples.
  Frequency get avgCadence {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    if (samples.length == 1) {
      return samples.first.cadence;
    }

    final total = samples.fold<double>(
      0,
      (sum, sample) => sum + sample.cadence.inPerMinute,
    );
    final averageRpmPerMin = total / samples.length;

    return Frequency.perMinute(averageRpmPerMin);
  }

  /// The minimum cadence value among all samples.
  Frequency get minCadence {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.cadence)
        .reduce((a, b) => (a.inPerMinute < b.inPerMinute) ? a : b);
  }

  /// The maximum cadence value among all samples.
  Frequency get maxCadence {
    if (samples.isEmpty) {
      return Frequency.zero;
    }
    return samples
        .map((s) => s.cadence)
        .reduce((a, b) => (a.inPerMinute > b.inPerMinute) ? a : b);
  }

  /// Creates a copy with the given fields replaced with the new values.
  CyclingPedalingCadenceSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<CyclingPedalingCadenceSample>? samples,
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
          const ListEquality<CyclingPedalingCadenceSample>().equals(
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
      const ListEquality<CyclingPedalingCadenceSample>().hash(samples);
}

/// Represents a single cycling pedaling cadence sample at a specific
/// point in time.
///
/// **Note**: This class does not have an ID or metadata. Those are
/// properties of the record that contains the measurement.
///
/// {@category Health Records}
@immutable
final class CyclingPedalingCadenceSample {
  /// Minimum valid cycling cadence.
  static final Frequency minCadence = CyclingPedalingCadenceRecord.minCadence;

  /// Maximum valid cycling cadence.
  static final Frequency maxCadence = CyclingPedalingCadenceRecord.maxCadence;

  /// Creates a cycling pedaling cadence measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [cadence] is outside the valid range of
  ///   [minCadence]-[maxCadence] RPM.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minCadence] RPM)**: Not pedaling (coasting).
  /// - **Maximum ([maxCadence] RPM)**: Typical cadence 60-100 RPM; elite
  ///   cyclists ~120 RPM; 200 RPM allows for brief sprint peaks.
  CyclingPedalingCadenceSample({
    required this.time,
    required this.cadence,
  }) {
    require(
      condition: cadence >= minCadence && cadence <= maxCadence,
      value: cadence,
      name: 'cadence',
      message:
          'Cycling cadence must be between '
          '${minCadence.inPerMinute.toStringAsFixed(0)}-'
          '${maxCadence.inPerMinute.toStringAsFixed(0)} RPM. '
          'Got ${cadence.inPerMinute.toStringAsFixed(0)} RPM.',
    );
  }

  /// The timestamp when this cadence measurement was taken, stored as a
  /// UTC instant.
  ///
  /// Timezone offset information is provided by the parent record.
  final DateTime time;

  /// The cycling cadence value in revolutions per minute (RPM).
  final Frequency cadence;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          cadence == other.cadence;

  @override
  int get hashCode => time.hashCode ^ cadence.hashCode;
}
