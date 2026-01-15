part of '../health_record.dart';

/// Represents a series of steps cadence samples.
///
/// A steps cadence series record is a container with a time range and multiple
/// cadence measurements taken during that period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`StepsCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsCadenceRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Example
///
/// ```dart
/// final record = StepsCadenceSeriesRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   samples: [
///     StepsCadenceSample(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       cadence: Frequency.perMinute(120),
///     ),
///     StepsCadenceSample(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       cadence: Frequency.perMinute(130),
///     ),
///   ],
///   metadata: Metadata.fromDevice(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [StepsCadenceSeriesDataType]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnHealthConnect
@immutable
final class StepsCadenceSeriesRecord
    extends SeriesHealthRecord<StepsCadenceSample> {
  /// Creates a steps cadence series record.
  StepsCadenceSeriesRecord({
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [StepsCadenceSeriesRecord] instances
  /// without validation.
  ///
  /// Creates a [StepsCadenceSeriesRecord] by directly mapping platform data
  /// to fields, bypassing the normal validation and business rules applied by
  /// the public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [StepsCadenceSeriesRecord] constructor, which enforces validation and
  /// business rules. This factory is restricted to the SDK developers and
  /// contributors.
  @internalUse
  factory StepsCadenceSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<StepsCadenceSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return StepsCadenceSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  StepsCadenceSeriesRecord._({
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
    final averageInPerMinute = total / samples.length;

    return Frequency.perMinute(averageInPerMinute);
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
  StepsCadenceSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<StepsCadenceSample>? samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return StepsCadenceSeriesRecord(
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
      other is StepsCadenceSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          const ListEquality<StepsCadenceSample>().equals(
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

/// Represents a single steps cadence sample at a specific point in time.
///
/// **Note**: This class does not have an ID or metadata. Those are
/// properties of the record that contains the measurement.
///
/// {@category Health Records}
@immutable
final class StepsCadenceSample {
  /// Minimum valid steps cadence.
  static final Frequency minCadence = Frequency.perMinute(0);

  /// Maximum valid steps cadence.
  static final Frequency maxCadence = Frequency.perMinute(10000);

  /// Creates a steps cadence sample.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [cadence] is outside the valid range of
  ///   [minCadence]-[maxCadence].
  StepsCadenceSample({
    required this.time,
    required this.cadence,
  }) {
    require(
      condition: cadence >= minCadence && cadence <= maxCadence,
      value: cadence,
      name: 'cadence',
      message:
          'Steps cadence must be between '
          '${minCadence.inPerMinute.toStringAsFixed(0)}-'
          '${maxCadence.inPerMinute.toStringAsFixed(0)} steps/min. '
          'Got ${cadence.inPerMinute.toStringAsFixed(0)} steps/min.',
    );
  }

  /// The timestamp when this cadence measurement was taken.
  final DateTime time;

  /// The steps cadence value in steps per minute.
  final Frequency cadence;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsCadenceSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          cadence == other.cadence;

  @override
  int get hashCode => time.hashCode ^ cadence.hashCode;
}
