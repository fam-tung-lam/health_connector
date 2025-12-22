part of '../health_record.dart';

/// Represents walking/running distance over a time interval.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.walkingRunning`
///
/// ## Example
/// ```dart
/// final record = WalkingRunningDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   distance: Length.meters(1500),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingRunningDistanceRecord extends DistanceActivityRecord {
  /// Creates a swimming distance record.
  const WalkingRunningDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingRunningDistanceRecord &&
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
