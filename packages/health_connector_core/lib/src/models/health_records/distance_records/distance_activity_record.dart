part of '../health_record.dart';

/// Base class for activity-specific distance records.
///
/// This sealed class represents distance measurements for specific activity types
/// exclusively for iOS/HealthKit. Each subclass maps to a specific
/// `HKQuantityTypeIdentifier` in HealthKit.
///
/// ## Platform Availability
///
/// **These records are ONLY supported on iOS/HealthKit.** They are marked with
/// `@supportedOnAppleHealth` and will not compile when targeting Android.
///
/// For cross-platform distance tracking (walking/running), use [DistanceRecord].
///
/// ## Subclasses
///
/// - [CyclingDistanceRecord] - Cycling distance
/// - [SwimmingDistanceRecord] - Swimming distance
/// - [WheelchairDistanceRecord] - Wheelchair distance
/// - [DownhillSnowSportsDistanceRecord] - Skiing/snowboarding distance
/// - [RowingDistanceRecord] - Rowing distance (iOS 18+)
/// - [PaddleSportsDistanceRecord] - Kayaking/paddleboarding (iOS 18+)
/// - [CrossCountrySkiingDistanceRecord] - Nordic skiing (iOS 18+)
/// - [SkatingSportsDistanceRecord] - Ice/roller skating (iOS 18+)
/// - [SixMinuteWalkTestDistanceRecord] - Medical walk test distance
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
sealed class DistanceActivityRecord extends IntervalHealthRecord {
  /// Creates a distance activity record.
  const DistanceActivityRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.distance,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The distance measurement value.
  final Length distance;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
