part of '../health_data_type.dart';

/// Health data type for total fat intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class TotalFatNutrientDataType
    extends MacronutrientDataType<TotalFatNutrientRecord>
    implements
        ReadableHealthDataType<TotalFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<TotalFatNutrientRecord, Mass> {
  @internal
  const TotalFatNutrientDataType();

  @override
  String get identifier => 'total_fat';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'total_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<TotalFatNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<TotalFatNutrientRecord> readInTimeRange({
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
  AggregateRequest<TotalFatNutrientRecord, Mass> aggregateSum({
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
