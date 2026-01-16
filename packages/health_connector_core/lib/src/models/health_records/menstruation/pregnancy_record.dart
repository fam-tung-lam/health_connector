part of '../health_record.dart';

/// {@template PregnancyRecord}
/// A record capturing the pregnancy period.
/// {@endtemplate}
@sinceV3_1_0
@supportedOnAppleHealth
class PregnancyRecord extends IntervalHealthRecord {
  /// {@macro PregnancyRecord}
  PregnancyRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// {@macro PregnancyRecord}
  @internalUse
  factory PregnancyRecord.fromRecord({
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PregnancyRecord(
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a copy of this record with the given fields replaced by the
  /// new values.
  PregnancyRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return PregnancyRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PregnancyRecord &&
            runtimeType == other.runtimeType &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
            endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
            metadata == other.metadata &&
            id == other.id;
  }

  @override
  int get hashCode =>
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      metadata.hashCode ^
      id.hashCode;
}
