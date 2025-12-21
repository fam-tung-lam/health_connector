part of '../health_data_type.dart';

/// Health data type for vitamin d intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminDNutrientDataType
    extends VitaminNutrientDataType<VitaminDNutrientRecord>
    implements
        ReadableHealthDataType<VitaminDNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminDNutrientRecord, Mass> {
  @internal
  const VitaminDNutrientDataType();

  @override
  String get identifier => 'vitamin_d';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<VitaminDNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<VitaminDNutrientRecord> readInTimeRange({
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
  AggregateRequest<VitaminDNutrientRecord, Mass> aggregateSum({
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
