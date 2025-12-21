part of '../health_data_type.dart';

/// Health data type for biotin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class BiotinNutrientDataType
    extends VitaminNutrientDataType<BiotinNutrientRecord>
    implements
        ReadableHealthDataType<BiotinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<BiotinNutrientRecord, Mass> {
  @internal
  const BiotinNutrientDataType();

  @override
  String get identifier => 'biotin';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BiotinNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BiotinNutrientRecord> readInTimeRange({
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
  AggregateRequest<BiotinNutrientRecord, Mass> aggregateSum({
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
