part of '../health_record.dart';

/// Represents downhill snow sports distance over a time interval.
///
/// Includes skiing, snowboarding, and other downhill winter sports.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.distanceDownhillSnowSports`
///
/// ## Example
/// ```dart
/// final record = DownhillSnowSportsDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 4)),
///   endTime: DateTime.now(),
///   distance: Length.kilometers(15),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class DownhillSnowSportsDistanceRecord extends DistanceActivityRecord {
  /// Creates a downhill snow sports distance record.
  const DownhillSnowSportsDistanceRecord({
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
      other is DownhillSnowSportsDistanceRecord &&
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
