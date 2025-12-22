part of '../health_data_type.dart';

/// Health data type for monounsaturated fat intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class MonounsaturatedFatNutrientDataType
    extends MacronutrientDataType<MonounsaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<MonounsaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<MonounsaturatedFatNutrientRecord, Mass> {
  @internal
  const MonounsaturatedFatNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonounsaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MonounsaturatedFatNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MonounsaturatedFatNutrientRecord>
  readInTimeRange({
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
  AggregateRequest<MonounsaturatedFatNutrientRecord, Mass> aggregateSum({
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
