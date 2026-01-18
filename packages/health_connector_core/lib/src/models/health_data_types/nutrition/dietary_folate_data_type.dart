part of '../health_data_type.dart';

/// Folate (Vitamin B9) data type.
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
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFolate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfolate)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query folate (vitamin b9) intake records
/// - Writeable: Write folate (vitamin b9) intake records
/// - Aggregatable: Sum total folate (vitamin b9) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryFolateRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryFolateDataType
    extends DietaryVitaminDataType<DietaryFolateRecord>
    implements
        ReadableByIdHealthDataType<DietaryFolateRecord>,
        ReadableInTimeRangeHealthDataType<DietaryFolateRecord>,
        WriteableHealthDataType<DietaryFolateRecord>,
        SumAggregatableHealthDataType<DietaryFolateRecord, Mass>,
        DeletableByIdsHealthDataType<DietaryFolateRecord>,
        DeletableInTimeRangeHealthDataType<DietaryFolateRecord> {
  /// Creates a folate (vitamin b9) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryFolateDataType();

  @override
  String get id => 'dietary_folate';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryFolateRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryFolateRecord> readInTimeRange({
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
  AggregateRequest<DietaryFolateRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
