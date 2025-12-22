part of '../health_data_type.dart';

/// Health data type for cholesterol intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CholesterolNutrientDataType
    extends MacronutrientDataType<CholesterolNutrientRecord>
    implements
        ReadableHealthDataType<CholesterolNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CholesterolNutrientRecord, Mass> {
  @internal
  const CholesterolNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CholesterolNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CholesterolNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CholesterolNutrientRecord> readInTimeRange({
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
  AggregateRequest<CholesterolNutrientRecord, Mass> aggregateSum({
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
