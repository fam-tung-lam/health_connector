part of '../health_record.dart';

/// Represents a high heart rate event record.
///
/// A high heart rate event occurs when the heart rate exceeds a certain
/// threshold.
///
/// ## See also
///
/// - [HighHeartRateEventDataType]
/// - [LowHeartRateEventDataType]
/// - [LowHeartRateEventRecord]
/// - [IrregularHeartRhythmEventDataType]
/// - [IrregularHeartRhythmEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class HighHeartRateEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [HighHeartRateEventRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HighHeartRateEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    Frequency? rateThreshold,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HighHeartRateEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      rateThreshold: rateThreshold,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a high heart rate event record.
  HighHeartRateEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    this.rateThreshold,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The threshold value associated with the event if available.
  final Frequency? rateThreshold;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighHeartRateEventRecord &&
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
