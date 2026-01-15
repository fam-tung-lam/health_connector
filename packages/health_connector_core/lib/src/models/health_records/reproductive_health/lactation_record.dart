part of '../health_record.dart';

/// {@category Reproductive Health}
/// {@category Health Records}
/// A record representing a lactation event.
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
class LactationRecord extends IntervalHealthRecord {
  /// {@macro health_record.new}
  LactationRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// {@macro health_record.internal}
  @internalUse
  factory LactationRecord.internal({
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required HealthRecordId id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return LactationRecord._(
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  LactationRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy of this record with the given fields replaced by the new values.
  LactationRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return LactationRecord(
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LactationRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode;
}
