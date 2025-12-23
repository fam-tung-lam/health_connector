part of '../health_data_type.dart';

/// Phosphorus nutrient data type.
///
/// Tracks dietary phosphorus intake, a essential mineral vital for bones,
/// teeth, and energy production.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.dietaryPhosphorus)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query phosphorus intake records
/// - ✅ Writeable: Write phosphorus intake records
/// - ✅ Aggregatable: Sum total phosphorus intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PhosphorusNutrientDataType
    extends MineralNutrientDataType<PhosphorusNutrientRecord>
    implements
        ReadableHealthDataType<PhosphorusNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PhosphorusNutrientRecord, Mass>,
        DeletableHealthDataType<PhosphorusNutrientRecord> {
  /// Creates a phosphorus nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PhosphorusNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PhosphorusNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PhosphorusNutrientRecord> readInTimeRange({
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
  AggregateRequest<PhosphorusNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<PhosphorusNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<PhosphorusNutrientRecord> deleteInTimeRange({
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
