part of '../health_data_type.dart';

/// Thiamin (Vitamin B1) data type.
///
/// Tracks dietary thiamin (vitamin b1) intake, a water-soluble vitamin that
/// helps convert nutrients into energy.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryThiamin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query thiamin (vitamin b1) intake records
/// - Writeable: Write thiamin (vitamin b1) intake records
/// - Aggregatable: Sum total thiamin (vitamin b1) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryThiaminRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryThiaminDataType
    extends DietaryVitaminDataType<DietaryThiaminRecord>
    implements
        ReadableByIdHealthDataType<DietaryThiaminRecord>,
        ReadableInTimeRangeHealthDataType<DietaryThiaminRecord>,
        WriteableHealthDataType<DietaryThiaminRecord>,
        SumAggregatableHealthDataType<Mass>,
        DeletableByIdsHealthDataType<DietaryThiaminRecord>,
        DeletableInTimeRangeHealthDataType<DietaryThiaminRecord> {
  /// Creates a thiamin (vitamin b1) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryThiaminDataType();

  @override
  String get id => 'dietary_thiamin';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryThiaminRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryThiaminRecord> readInTimeRange({
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
  AggregateRequest<Mass> aggregateSum({
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
