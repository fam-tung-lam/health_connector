part of '../health_data_type.dart';

/// Base class for activity-specific speed health data types.
///
/// This sealed class represents data types for activity-specific speed
/// tracking exclusively on iOS/HealthKit.
///
/// ## Platform Availability
///
/// **These data types are ONLY supported on iOS/HealthKit.** They are marked
/// with `@supportedOnAppleHealth` and will not compile when targeting Android.
///
/// For cross-platform speed tracking, use [SpeedSeriesDataType] that is only
/// available on Android Health Connect.
///
/// ## Subclasses
///
/// - [WalkingSpeedDataType]
/// - [RunningSpeedDataType]
/// - [StairAscentSpeedDataType]
/// - [StairDescentSpeedDataType]
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
sealed class SpeedActivityHealthDataType<R extends SpeedActivityRecord>
    extends HealthDataType<R, Velocity>
    implements
        ReadableHealthDataType<R>,
        WriteableHealthDataType,
        DeletableHealthDataType,
        AvgAggregatableHealthDataType<R, Velocity> {
  @internal
  const SpeedActivityHealthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
