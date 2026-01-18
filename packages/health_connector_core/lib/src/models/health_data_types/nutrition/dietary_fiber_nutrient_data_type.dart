part of '../health_data_type.dart';

/// Dietary fiber data type.
///
/// Tracks dietary dietary fiber intake, a indigestible carbohydrate important
/// for digestive health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFiber`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfiber)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query dietary fiber intake records
/// - Writeable: Write dietary fiber intake records
/// - Aggregatable: Sum total dietary fiber intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryFiberRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryFiberNutrientDataType
    extends MacronutrientDataType<DietaryFiberRecord>
    implements
        ReadableByIdHealthDataType<DietaryFiberRecord>,
        ReadableInTimeRangeHealthDataType<DietaryFiberRecord>,
        WriteableHealthDataType<DietaryFiberRecord>,
        SumAggregatableHealthDataType<DietaryFiberRecord, Mass>,
        DeletableByIdsHealthDataType<DietaryFiberRecord>,
        DeletableInTimeRangeHealthDataType<DietaryFiberRecord> {
  /// Creates a dietary fiber data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryFiberNutrientDataType();

  @override
  String get id => 'dietary_fiber';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryFiberNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryFiberRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryFiberRecord> readInTimeRange({
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
  AggregateRequest<DietaryFiberRecord, Mass> aggregateSum({
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
