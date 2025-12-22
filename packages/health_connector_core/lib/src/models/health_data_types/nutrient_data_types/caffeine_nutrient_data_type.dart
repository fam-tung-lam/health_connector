part of '../health_data_type.dart';

/// Health data type for caffeine intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CaffeineNutrientDataType
    extends NutrientHealthDataType<CaffeineNutrientRecord, Mass>
    implements
        ReadableHealthDataType<CaffeineNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CaffeineNutrientRecord, Mass> {
  @internal
  const CaffeineNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaffeineNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CaffeineNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CaffeineNutrientRecord> readInTimeRange({
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
  AggregateRequest<CaffeineNutrientRecord, Mass> aggregateSum({
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
