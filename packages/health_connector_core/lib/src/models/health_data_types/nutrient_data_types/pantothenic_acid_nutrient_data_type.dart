part of '../health_data_type.dart';

/// Health data type for pantothenic acid intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PantothenicAcidNutrientDataType
    extends VitaminNutrientDataType<PantothenicAcidNutrientRecord>
    implements
        ReadableHealthDataType<PantothenicAcidNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PantothenicAcidNutrientRecord, Mass> {
  @internal
  const PantothenicAcidNutrientDataType();

  @override
  String get identifier => 'pantothenic_acid';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PantothenicAcidNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PantothenicAcidNutrientRecord> readInTimeRange({
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
  AggregateRequest<PantothenicAcidNutrientRecord, Mass> aggregateSum({
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
