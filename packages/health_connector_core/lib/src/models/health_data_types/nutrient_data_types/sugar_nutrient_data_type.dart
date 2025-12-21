part of '../health_data_type.dart';

/// Health data type for sugar intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SugarNutrientDataType
    extends MacronutrientDataType<SugarNutrientRecord>
    implements
        ReadableHealthDataType<SugarNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SugarNutrientRecord, Mass> {
  @internal
  const SugarNutrientDataType();

  @override
  String get identifier => 'sugar';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SugarNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'sugar_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SugarNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SugarNutrientRecord> readInTimeRange({
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
  AggregateRequest<SugarNutrientRecord, Mass> aggregateSum({
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
