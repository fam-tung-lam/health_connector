part of '../health_record.dart';

/// Represents a walking speed measurement at a specific point in time.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.walkingSpeed`
///
/// ## Example
/// ```dart
/// final record = WalkingSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(1.4),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingSpeedRecord extends SpeedActivityRecord {
  /// Creates a walking speed record.
  const WalkingSpeedRecord({
    required super.time,
    required super.metadata,
    required super.speed,
    super.id,
    super.zoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSpeedRecord &&
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
