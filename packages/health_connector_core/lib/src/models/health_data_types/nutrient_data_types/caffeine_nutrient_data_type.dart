part of '../health_data_type.dart';

/// Caffeine nutrient data type.
///
/// Tracks dietary caffeine intake, a stimulant compound affecting the central
/// nervous system, found in coffee and tea.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.dietaryCaffeine)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query caffeine intake records
/// - ✅ Writeable: Write caffeine intake records
/// - ✅ Aggregatable: Sum total caffeine intake
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CaffeineNutrientDataType
    extends NutrientHealthDataType<CaffeineNutrientRecord, Mass>
    implements
        ReadableHealthDataType<CaffeineNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CaffeineNutrientRecord, Mass>,
        DeletableHealthDataType<CaffeineNutrientRecord> {
  /// Creates a caffeine nutrient data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CaffeineNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaffeineNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CaffeineNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CaffeineNutrientRecord> readInTimeRange({
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

  @override
  DeleteRecordsByIdsRequest<CaffeineNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<CaffeineNutrientRecord> deleteInTimeRange({
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
