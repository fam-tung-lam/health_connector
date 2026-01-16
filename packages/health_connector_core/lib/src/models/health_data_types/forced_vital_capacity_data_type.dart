part of 'health_data_type.dart';

/// Forced vital capacity data type.
///
/// Represents the user's forced vital capacity measurements.
/// Supports AVG, MIN, MAX aggregation.
///
/// **Platform:** iOS HealthKit only.
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ForcedVitalCapacityDataType
    extends HealthDataType<ForcedVitalCapacityRecord, Volume>
    implements
        AvgAggregatableHealthDataType<ForcedVitalCapacityRecord, Volume>,
        MinAggregatableHealthDataType<ForcedVitalCapacityRecord, Volume>,
        MaxAggregatableHealthDataType<ForcedVitalCapacityRecord, Volume> {
  /// Creates a forced vital capacity data type.
  const ForcedVitalCapacityDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'forcedVitalCapacity';

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  /// The read permission for this data type.
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  /// The write permission for this data type.
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  AggregateRequest<ForcedVitalCapacityRecord, Volume> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<ForcedVitalCapacityRecord, Volume> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<ForcedVitalCapacityRecord, Volume> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
