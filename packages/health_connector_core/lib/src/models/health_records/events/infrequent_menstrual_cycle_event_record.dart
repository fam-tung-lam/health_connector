part of '../health_record.dart';

/// Represents an infrequent menstrual cycle event record.
///
/// ## See also
///
/// - [InfrequentMenstrualCycleEventDataType]
/// - [MenstrualFlowRecord]
/// - [IntermenstrualBleedingRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class InfrequentMenstrualCycleEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [InfrequentMenstrualCycleEventRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory InfrequentMenstrualCycleEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return InfrequentMenstrualCycleEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates an infrequent menstrual cycle event record.
  InfrequentMenstrualCycleEventRecord._({
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
      other is InfrequentMenstrualCycleEventRecord &&
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
