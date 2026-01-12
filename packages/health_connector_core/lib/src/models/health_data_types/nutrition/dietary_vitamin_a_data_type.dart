part of '../health_data_type.dart';

/// Vitamin A data type.
///
/// Tracks dietary vitamin a intake, a fat-soluble vitamin essential for vision,
/// immune function, and cell growth.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminA`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamina)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query vitamin a intake records
/// - Writeable: Write vitamin a intake records
/// - Aggregatable: Sum total vitamin a intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryVitaminARecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminADataType
    extends DietaryVitaminDataType<DietaryVitaminARecord>
    implements
        ReadableHealthDataType<DietaryVitaminARecord>,
        WriteableHealthDataType<DietaryVitaminARecord>,
        SumAggregatableHealthDataType<DietaryVitaminARecord, Mass>,
        DeletableHealthDataType<DietaryVitaminARecord> {
  /// Creates a vitamin a data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryVitaminADataType();

  @override
  String get id => 'dietary_vitamin_a';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryVitaminARecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryVitaminARecord> readInTimeRange({
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
  AggregateRequest<DietaryVitaminARecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietaryVitaminARecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryVitaminARecord> deleteInTimeRange({
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
