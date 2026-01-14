part of '../health_data_type.dart';

/// Base class for activity-specific distance health data types.
///
/// This sealed class represents data types for activity-specific distance
/// tracking exclusively on iOS/HealthKit.
///
/// ## Platform Availability
///
/// **These data types are ONLY supported on iOS/HealthKit.** They are marked
/// with `@supportedOnAppleHealth` and will not compile when targeting Android.
///
/// For cross-platform distance tracking, use [DistanceDataType].
///
/// ## Subclasses
///
/// - [CyclingDistanceDataType]
/// - [SwimmingDistanceDataType]
/// - [WheelchairDistanceDataType]
/// - [DownhillSnowSportsDistanceDataType]
/// - [RowingDistanceDataType] (iOS 18+)
/// - [PaddleSportsDistanceDataType] (iOS 18+)
/// - [CrossCountrySkiingDistanceDataType] (iOS 18+)
/// - [SkatingSportsDistanceDataType] (iOS 18+)
/// - [SixMinuteWalkTestDistanceDataType]
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
sealed class DistanceActivityDataType<R extends DistanceActivityRecord>
    extends HealthDataType<R, Length>
    implements
        ReadableHealthDataType<R>,
        WriteableHealthDataType<R>,
        DeletableHealthDataType,
        SumAggregatableHealthDataType<R, Length> {
  @internal
  const DistanceActivityDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;
}
