part of '../health_data_type.dart';

/// Health data type for protein intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ProteinNutrientDataType
    extends MacronutrientDataType<ProteinNutrientRecord>
    implements
        ReadableHealthDataType<ProteinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ProteinNutrientRecord, Mass> {
  @internal
  const ProteinNutrientDataType();

  @override
  String get identifier => 'protein';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProteinNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'protein_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ProteinNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ProteinNutrientRecord> readInTimeRange({
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
  AggregateRequest<ProteinNutrientRecord, Mass> aggregateSum({
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
