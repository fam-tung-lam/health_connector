part of '../health_data_type.dart';

/// Riboflavin (Vitamin B2) nutrient data type.
///
/// Tracks dietary riboflavin (vitamin b2) intake, a water-soluble vitamin
/// supporting cellular function and energy production.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.dietaryRiboflavin)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query riboflavin (vitamin b2) intake records
/// - ✅ Writeable: Write riboflavin (vitamin b2) intake records
/// - ✅ Aggregatable: Sum total riboflavin (vitamin b2) intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class RiboflavinNutrientDataType
    extends VitaminNutrientDataType<RiboflavinNutrientRecord>
    implements
        ReadableHealthDataType<RiboflavinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<RiboflavinNutrientRecord, Mass>,
        DeletableHealthDataType<RiboflavinNutrientRecord> {
  /// Creates a riboflavin (vitamin b2) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const RiboflavinNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<RiboflavinNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RiboflavinNutrientRecord> readInTimeRange({
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
  AggregateRequest<RiboflavinNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<RiboflavinNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<RiboflavinNutrientRecord> deleteInTimeRange({
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
