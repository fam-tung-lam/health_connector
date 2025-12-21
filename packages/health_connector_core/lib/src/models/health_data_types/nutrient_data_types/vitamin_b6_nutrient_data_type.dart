part of '../health_data_type.dart';

/// Health data type for vitamin b6 intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminB6NutrientDataType
    extends VitaminNutrientDataType<VitaminB6NutrientRecord>
    implements
        ReadableHealthDataType<VitaminB6NutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminB6NutrientRecord, Mass> {
  @internal
  const VitaminB6NutrientDataType();

  @override
  String get identifier => 'vitamin_b6';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<VitaminB6NutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<VitaminB6NutrientRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<VitaminB6NutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
