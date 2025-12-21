part of '../health_data_type.dart';

/// Health data type for thiamin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ThiaminNutrientDataType
    extends VitaminNutrientDataType<ThiaminNutrientRecord>
    implements
        ReadableHealthDataType<ThiaminNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ThiaminNutrientRecord, Mass> {
  @internal
  const ThiaminNutrientDataType();

  @override
  String get identifier => 'thiamin';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ThiaminNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ThiaminNutrientRecord> readInTimeRange({
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
  AggregateRequest<ThiaminNutrientRecord, Mass> aggregateSum({
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
