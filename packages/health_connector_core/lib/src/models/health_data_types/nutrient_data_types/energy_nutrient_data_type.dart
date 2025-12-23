part of '../health_data_type.dart';

/// Energy (calories) nutrient data type.
///
/// Tracks dietary energy (calories) intake, a total caloric intake from all
/// macronutrient sources.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilocalories typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.dietaryEnergyConsumed)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query energy (calories) intake records
/// - ✅ Writeable: Write energy (calories) intake records
/// - ✅ Aggregatable: Sum total energy (calories) intake
/// - ✅ Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class EnergyNutrientDataType
    extends NutrientHealthDataType<EnergyNutrientRecord, Energy>
    implements
        ReadableHealthDataType<EnergyNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<EnergyNutrientRecord, Energy>,
        DeletableHealthDataType<EnergyNutrientRecord> {
  /// Creates a energy (calories) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const EnergyNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<EnergyNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<EnergyNutrientRecord> readInTimeRange({
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

  @override
  DeleteRecordsByIdsRequest<EnergyNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<EnergyNutrientRecord> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return DeleteRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
