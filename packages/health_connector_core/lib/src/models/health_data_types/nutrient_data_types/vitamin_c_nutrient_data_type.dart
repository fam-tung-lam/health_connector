part of '../health_data_type.dart';

/// Health data type for vitamin c intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminCNutrientDataType
    extends VitaminNutrientDataType<VitaminCNutrientRecord>
    implements
        ReadableHealthDataType<VitaminCNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminCNutrientRecord, Mass> {
  @internal
  const VitaminCNutrientDataType();

  @override
  String get identifier => 'vitamin_c';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<VitaminCNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<VitaminCNutrientRecord> readInTimeRange({
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
  AggregateRequest<VitaminCNutrientRecord, Mass> aggregateSum({
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
