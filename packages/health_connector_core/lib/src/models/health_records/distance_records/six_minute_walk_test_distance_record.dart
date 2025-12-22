part of '../health_record.dart';

/// Represents six-minute walk test distance.
///
/// A standardized medical assessment measuring the distance walked in
/// six minutes, commonly used to evaluate functional exercise capacity.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.sixMinuteWalkTestDistance`
///
/// ## Example
/// ```dart
/// final record = SixMinuteWalkTestDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 6)),
///   endTime: DateTime.now(),
///   distance: Length.meters(450),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class SixMinuteWalkTestDistanceRecord extends DistanceActivityRecord {
  /// Creates a six-minute walk test distance record.
  const SixMinuteWalkTestDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  SixMinuteWalkTestDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SixMinuteWalkTestDistanceRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distance: distance ?? this.distance,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SixMinuteWalkTestDistanceRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          distance == other.distance &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      distance.hashCode ^
      metadata.hashCode;
}
