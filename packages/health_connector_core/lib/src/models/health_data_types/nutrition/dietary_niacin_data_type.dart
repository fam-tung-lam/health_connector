part of '../health_data_type.dart';

/// Niacin (Vitamin B3) data type.
///
/// Tracks dietary niacin (vitamin b3) intake, a water-soluble vitamin
/// supporting metabolism and DNA repair.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryNiacin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query niacin (vitamin b3) intake records
/// - Writeable: Write niacin (vitamin b3) intake records
/// - Aggregatable: Sum total niacin (vitamin b3) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryNiacinRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryNiacinDataType
    extends DietaryVitaminDataType<DietaryNiacinRecord>
    implements
        ReadableByIdHealthDataType<DietaryNiacinRecord>,
        ReadableInTimeRangeHealthDataType<DietaryNiacinRecord>,
        WriteableHealthDataType<DietaryNiacinRecord>,
        SumAggregatableHealthDataType<DietaryNiacinRecord, Mass>,
        DeletableByIdsHealthDataType<DietaryNiacinRecord>,
        DeletableInTimeRangeHealthDataType<DietaryNiacinRecord> {
  /// Creates a niacin (vitamin b3) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryNiacinDataType();

  @override
  String get id => 'dietary_niacin';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryNiacinRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryNiacinRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    List<DataOrigin> dataOrigins = const [],
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      dataOrigins: dataOrigins,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<DietaryNiacinRecord, Mass> aggregateSum({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.nutrition;

  @override
  DeleteRecordsByIdsRequest<DietaryNiacinRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryNiacinRecord> deleteInTimeRange({
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
