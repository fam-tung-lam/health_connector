part of '../health_record.dart';

/// Represents a low heart rate event record.
///
/// A low heart rate event occurs when the heart rate drops below a certain
/// threshold.
///
/// ## See also
///
/// - [LowHeartRateEventDataType]
/// - [HighHeartRateEventDataType]
/// - [HighHeartRateEventRecord]
/// - [IrregularHeartRhythmEventDataType]
/// - [IrregularHeartRhythmEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class LowHeartRateEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [LowHeartRateEventRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory LowHeartRateEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    Frequency? rateThreshold,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return LowHeartRateEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      rateThreshold: rateThreshold,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a low heart rate event record.
  LowHeartRateEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    this.rateThreshold,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The threshold value associated with the event.
  final Frequency? rateThreshold;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LowHeartRateEventRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          rateThreshold == other.rateThreshold &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      rateThreshold.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode;
}
