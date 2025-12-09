part of '../health_data_type.dart';

@sinceV1_0_0
@internal
@immutable
sealed class NutrientHealthDataType<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    extends HealthDataType<R, U> {
  const NutrientHealthDataType();
}

/// Health data type for energy (calorie) intake.
@sinceV1_1_0
@immutable
final class EnergyNutrientDataType
    extends NutrientHealthDataType<EnergyNutrientRecord, Energy>
    implements
        ReadableHealthDataType<EnergyNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<EnergyNutrientRecord, Energy> {
  @internal
  const EnergyNutrientDataType();

  @override
  String get identifier => 'energy_nutrient';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'energy_nutrient_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<EnergyNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<EnergyNutrientRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  AggregateRequest<EnergyNutrientRecord, Energy> aggregateSum({
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

/// Health data type for caffeine intake.
@sinceV1_1_0
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
  String get identifier => 'caffeine';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaffeineNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'caffeine_nutrient_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<CaffeineNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<CaffeineNutrientRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

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
