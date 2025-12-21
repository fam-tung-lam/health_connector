part of '../health_data_type.dart';

/// Health data type for saturated fat intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SaturatedFatNutrientDataType
    extends MacronutrientDataType<SaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<SaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SaturatedFatNutrientRecord, Mass> {
  @internal
  const SaturatedFatNutrientDataType();

  @override
  String get identifier => 'saturated_fat';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'saturated_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SaturatedFatNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SaturatedFatNutrientRecord> readInTimeRange({
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
  AggregateRequest<SaturatedFatNutrientRecord, Mass> aggregateSum({
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
