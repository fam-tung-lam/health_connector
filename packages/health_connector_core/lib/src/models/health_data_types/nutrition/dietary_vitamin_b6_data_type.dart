part of '../health_data_type.dart';

/// Vitamin B6 (Pyridoxine) data type.
///
/// Tracks dietary vitamin b6 (pyridoxine) intake, a water-soluble vitamin
/// important for protein metabolism and cognitive development.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminB6`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb6)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query vitamin b6 (pyridoxine) intake records
/// - Writeable: Write vitamin b6 (pyridoxine) intake records
/// - Aggregatable: Sum total vitamin b6 (pyridoxine) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryVitaminB6Record]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminB6DataType
    extends DietaryVitaminDataType<DietaryVitaminB6Record>
    implements
        ReadableByIdHealthDataType<DietaryVitaminB6Record>,
        ReadableInTimeRangeHealthDataType<DietaryVitaminB6Record>,
        WriteableHealthDataType<DietaryVitaminB6Record>,
        SumAggregatableHealthDataType<DietaryVitaminB6Record, Mass>,
        DeletableHealthDataType<DietaryVitaminB6Record> {
  /// Creates a vitamin b6 (pyridoxine) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryVitaminB6DataType();

  @override
  String get id => 'dietary_vitamin_b6';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryVitaminB6Record> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryVitaminB6Record> readInTimeRange({
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
  AggregateRequest<DietaryVitaminB6Record, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietaryVitaminB6Record> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryVitaminB6Record> deleteInTimeRange({
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
