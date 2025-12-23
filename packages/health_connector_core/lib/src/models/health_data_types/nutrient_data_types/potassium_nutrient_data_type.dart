part of '../health_data_type.dart';

/// Potassium nutrient data type.
///
/// Tracks dietary potassium intake, a essential mineral crucial for heart
/// function and fluid balance.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryPotassium)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query potassium intake records
/// - ✅ Writeable: Write potassium intake records
/// - ✅ Aggregatable: Sum total potassium intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PotassiumNutrientDataType
    extends MineralNutrientDataType<PotassiumNutrientRecord>
    implements
        ReadableHealthDataType<PotassiumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PotassiumNutrientRecord, Mass>,
        DeletableHealthDataType<PotassiumNutrientRecord> {
  /// Creates a potassium nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PotassiumNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PotassiumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PotassiumNutrientRecord> readInTimeRange({
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
  AggregateRequest<PotassiumNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<PotassiumNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<PotassiumNutrientRecord> deleteInTimeRange({
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
