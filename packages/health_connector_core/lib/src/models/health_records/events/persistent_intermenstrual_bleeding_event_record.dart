part of '../health_record.dart';

/// Represents a persistent intermenstrual bleeding event record.
///
/// ## See also
///
/// - [PersistentIntermenstrualBleedingEventDataType]
/// - [MenstrualFlowRecord]
/// - [IntermenstrualBleedingRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class PersistentIntermenstrualBleedingEventRecord
    extends IntervalHealthRecord {
  /// Internal factory for creating
  /// [PersistentIntermenstrualBleedingEventRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory PersistentIntermenstrualBleedingEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PersistentIntermenstrualBleedingEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a persistent intermenstrual bleeding event record.
  PersistentIntermenstrualBleedingEventRecord._({
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
      other is PersistentIntermenstrualBleedingEventRecord &&
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
