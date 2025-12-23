part of '../health_data_type.dart';

/// Folate (Vitamin B9) nutrient data type.
///
/// Tracks dietary folate (vitamin b9) intake, a water-soluble vitamin vital for
/// DNA synthesis and cell division.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryFolate)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query folate (vitamin b9) intake records
/// - ✅ Writeable: Write folate (vitamin b9) intake records
/// - ✅ Aggregatable: Sum total folate (vitamin b9) intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class FolateNutrientDataType
    extends VitaminNutrientDataType<FolateNutrientRecord>
    implements
        ReadableHealthDataType<FolateNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<FolateNutrientRecord, Mass>,
        DeletableHealthDataType<FolateNutrientRecord> {
  /// Creates a folate (vitamin b9) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const FolateNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<FolateNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<FolateNutrientRecord> readInTimeRange({
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
  AggregateRequest<FolateNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<FolateNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<FolateNutrientRecord> deleteInTimeRange({
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
