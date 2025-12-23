part of '../health_data_type.dart';

/// Manganese nutrient data type.
///
/// Tracks dietary manganese intake, a trace mineral important for bone
/// formation and metabolism.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryManganese)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query manganese intake records
/// - ✅ Writeable: Write manganese intake records
/// - ✅ Aggregatable: Sum total manganese intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ManganeseNutrientDataType
    extends MineralNutrientDataType<ManganeseNutrientRecord>
    implements
        ReadableHealthDataType<ManganeseNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ManganeseNutrientRecord, Mass>,
        DeletableHealthDataType<ManganeseNutrientRecord> {
  /// Creates a manganese nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ManganeseNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ManganeseNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ManganeseNutrientRecord> readInTimeRange({
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
  AggregateRequest<ManganeseNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<ManganeseNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<ManganeseNutrientRecord> deleteInTimeRange({
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
