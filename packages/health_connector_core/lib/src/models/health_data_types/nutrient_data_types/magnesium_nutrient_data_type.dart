part of '../health_data_type.dart';

/// Health data type for magnesium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class MagnesiumNutrientDataType
    extends MineralNutrientDataType<MagnesiumNutrientRecord>
    implements
        ReadableHealthDataType<MagnesiumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<MagnesiumNutrientRecord, Mass> {
  @internal
  const MagnesiumNutrientDataType();

  @override
  String get identifier => 'magnesium';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MagnesiumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MagnesiumNutrientRecord> readInTimeRange({
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
  AggregateRequest<MagnesiumNutrientRecord, Mass> aggregateSum({
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
