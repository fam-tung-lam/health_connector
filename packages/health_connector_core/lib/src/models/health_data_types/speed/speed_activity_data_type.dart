part of '../health_data_type.dart';

/// Base class for activity-specific speed health data types.
///
/// This sealed class represents data types for activity-specific speed
/// tracking exclusively on iOS/HealthKit.
///
/// ## Subclasses
///
/// - [WalkingSpeedDataType]
/// - [RunningSpeedDataType]
/// - [StairAscentSpeedDataType]
/// - [StairDescentSpeedDataType]
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
sealed class SpeedActivityDataType<R extends SpeedActivityRecord>
    extends HealthDataType<R, Velocity>
    implements
        ReadableHealthDataType<R>,
        WriteableHealthDataType,
        DeletableHealthDataType,
        AvgAggregatableHealthDataType<R, Velocity> {
  @internal
  const SpeedActivityDataType();

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

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.mobility;
}
