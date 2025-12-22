part of '../health_record.dart';

/// Base class for activity-specific speed records.
///
/// This sealed class represents speed measurements for specific activity types
/// exclusively for iOS/HealthKit. Each subclass maps to a specific
/// `HKQuantityTypeIdentifier` in HealthKit.
///
/// ## Platform Availability
///
/// **These records are ONLY supported on iOS/HealthKit.** They are marked with
/// `@supportedOnAppleHealth` and will not compile when targeting Android.
///
/// For cross-platform speed tracking, use [SpeedSeriesRecord] (Android only).
///
/// ## Subclasses
///
/// - [WalkingSpeedRecord] - Walking speed
/// - [RunningSpeedRecord] - Running speed
/// - [StairAscentSpeedRecord] - Stair ascent speed
/// - [StairDescentSpeedRecord] - Stair descent speed
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
sealed class SpeedActivityRecord extends InstantHealthRecord {
  /// Creates a speed activity record.
  const SpeedActivityRecord({
    required super.time,
    required super.metadata,
    required this.speed,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The speed measurement value.
  final Velocity speed;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
