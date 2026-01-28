part of '../health_record.dart';

/// Represents a series of individual heartbeats (R-R intervals) measured over a
/// time interval.
///
/// ## See also
///
/// - [HeartbeatSeriesDataType]
/// - [HeartRateSeriesDataType]
/// - [HeartRateSeriesRecord]
///
/// {@category Health Records}
@sinceV3_7_0
@supportedOnAppleHealth
@immutable
final class HeartbeatSeriesRecord extends SeriesHealthRecord<HeartbeatSample> {
  /// Creates an instance of [HeartbeatSeriesRecord].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [samples] are not strictly increasing by
  ///   [HeartbeatSample.timeSinceSeriesStart].
  HeartbeatSeriesRecord({
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    _validateIncreasingOffsets();
  }

  /// Internal factory for creating [HeartbeatSeriesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HeartbeatSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<HeartbeatSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartbeatSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  HeartbeatSeriesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The total number of beats recorded in this series.
  int get beatCount => samples.length;

  /// Creates a copy with the given fields replaced with the new values.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [samples] are not strictly increasing by
  ///   [HeartbeatSample.timeSinceSeriesStart].
  HeartbeatSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<HeartbeatSample>? samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartbeatSeriesRecord(
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
      other is HeartbeatSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          const ListEquality<HeartbeatSample>().equals(
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
      const ListEquality<HeartbeatSample>().hash(samples);

  /// Validates that the samples are strictly increasing by
  /// [HeartbeatSample.timeSinceSeriesStart].
  ///
  /// This ensures that the beats are chronologically ordered.
  ///
  /// Throws [ArgumentError] if a subsequent beat occurs at or before the
  /// previous beat.
  void _validateIncreasingOffsets() {
    for (var i = 0; i < samples.length - 1; i++) {
      final current = samples[i];
      final next = samples[i + 1];

      if (next.timeSinceSeriesStart <= current.timeSinceSeriesStart) {
        throw ArgumentError(
          'Chronological error: Beat ${i + 1} (${next.timeSinceSeriesStart}) '
          'occurred before Beat $i (${current.timeSinceSeriesStart}).',
        );
      }
    }
  }
}

/// Represents a single heartbeat event relative to the start of a series.
///
/// This class is used exclusively as a sample type within
/// [HeartbeatSeriesRecord].
///
/// {@category Health Records}
@immutable
final class HeartbeatSample {
  /// Creates a heartbeat sample.
  ///
  /// ## Parameters
  ///
  /// - [timeSinceSeriesStart]: The time elapsed since the start of
  ///   the series record.
  /// - [precededByGap]: Whether there was a loss of data integrity
  ///   immediately preceding this beat (e.g., sensor lost contact).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [timeSinceSeriesStart] is negative.
  const HeartbeatSample({
    required this.timeSinceSeriesStart,
    required this.precededByGap,
  }) : assert(
         timeSinceSeriesStart >= Duration.zero,
         'Time since series start should be non-negative',
       );

  /// The time elapsed since the series [HeartbeatSeriesRecord.startTime] when
  /// this beat occurred.
  ///
  /// Example:
  /// - Series Start: 12:00:00
  /// - Beat 1: `timeSinceSeriesStart` = 0.8s (Absolute: 12:00:00.800)
  /// - Beat 2: `timeSinceSeriesStart` = 1.6s (Absolute: 12:00:01.600)
  final Duration timeSinceSeriesStart;

  /// Indicates if there was a gap in data collection immediately before
  /// this heartbeat.
  ///
  /// If `true`, the interval between this beat and the previous one cannot
  /// be reliably used for HRV calculations (SDNN/RMSSD), as beats may
  /// be missing.
  final bool precededByGap;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartbeatSample &&
          runtimeType == other.runtimeType &&
          timeSinceSeriesStart == other.timeSinceSeriesStart &&
          precededByGap == other.precededByGap;

  @override
  int get hashCode => timeSinceSeriesStart.hashCode ^ precededByGap.hashCode;
}
