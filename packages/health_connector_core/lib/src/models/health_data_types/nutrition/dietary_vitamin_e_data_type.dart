part of '../health_data_type.dart';

/// Vitamin E data type.
///
/// Tracks dietary vitamin e intake, a fat-soluble vitamin and antioxidant
/// protecting cells from damage.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminE`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query vitamin e intake records
/// - Writeable: Write vitamin e intake records
/// - Aggregatable: Sum total vitamin e intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryVitaminERecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminEDataType
    extends DietaryVitaminDataType<DietaryVitaminERecord>
    implements
        ReadableByIdHealthDataType<DietaryVitaminERecord>,
        ReadableInTimeRangeHealthDataType<DietaryVitaminERecord>,
        WriteableHealthDataType<DietaryVitaminERecord>,
        SumAggregatableHealthDataType<DietaryVitaminERecord, Mass>,
        DeletableByIdsHealthDataType<DietaryVitaminERecord>,
        DeletableInTimeRangeHealthDataType<DietaryVitaminERecord> {
  /// Creates a vitamin e data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryVitaminEDataType();

  @override
  String get id => 'dietary_vitamin_e';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryVitaminERecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryVitaminERecord> readInTimeRange({
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
  AggregateRequest<DietaryVitaminERecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietaryVitaminERecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryVitaminERecord> deleteInTimeRange({
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
