part of '../health_record.dart';

/// Represents a stair descent speed measurement at a specific point in time.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.stairDescentSpeed`
///
/// ## Example
/// ```dart
/// final record = StairDescentSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(0.6),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class StairDescentSpeedRecord extends SpeedActivityRecord {
  /// Creates a stair descent speed record.
  const StairDescentSpeedRecord({
    required super.time,
    required super.metadata,
    required super.speed,
    super.id,
    super.zoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StairDescentSpeedRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          speed == other.speed &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      speed.hashCode ^
      metadata.hashCode;
}
