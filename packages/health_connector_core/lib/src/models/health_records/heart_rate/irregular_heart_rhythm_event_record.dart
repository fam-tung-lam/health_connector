part of '../health_record.dart';

/// Represents an irregular heart rhythm event record.
///
/// An irregular heart rhythm event occurs when an irregular heart rhythm is
/// detected, such as atrial fibrillation (AFib).
///
/// ## See also
///
/// - [IrregularHeartRhythmEventDataType]
/// - [LowHeartRateEventDataType]
/// - [LowHeartRateEventRecord]
/// - [HighHeartRateEventDataType]
/// - [HighHeartRateEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class IrregularHeartRhythmEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [IrregularHeartRhythmEventRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory IrregularHeartRhythmEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return IrregularHeartRhythmEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates an irregular heart rhythm event record.
  IrregularHeartRhythmEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IrregularHeartRhythmEventRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode;
}
