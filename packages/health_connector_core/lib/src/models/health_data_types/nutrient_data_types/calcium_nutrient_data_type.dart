part of '../health_data_type.dart';

/// Health data type for calcium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CalciumNutrientDataType
    extends MineralNutrientDataType<CalciumNutrientRecord>
    implements
        ReadableHealthDataType<CalciumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CalciumNutrientRecord, Mass> {
  @internal
  const CalciumNutrientDataType();

  @override
  String get identifier => 'calcium';

  @override
  String toString() => 'calcium_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CalciumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CalciumNutrientRecord> readInTimeRange({
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
  AggregateRequest<CalciumNutrientRecord, Mass> aggregateSum({
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
