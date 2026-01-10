part of '../health_data_type.dart';

/// Saturated fat data type.
///
/// Tracks dietary saturated fat intake, a type of fat that should be limited
/// for cardiovascular health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatSaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query saturated fat intake records
/// - Writeable: Write saturated fat intake records
/// - Aggregatable: Sum total saturated fat intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietarySaturatedFatRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietarySaturatedFatDataType
    extends MacronutrientDataType<DietarySaturatedFatRecord>
    implements
        ReadableHealthDataType<DietarySaturatedFatRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DietarySaturatedFatRecord, Mass>,
        DeletableHealthDataType<DietarySaturatedFatRecord> {
  /// Creates a saturated fat data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietarySaturatedFatDataType();

  @override
  String get id => 'dietary_saturated_fat';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietarySaturatedFatDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietarySaturatedFatRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietarySaturatedFatRecord> readInTimeRange({
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
  AggregateRequest<DietarySaturatedFatRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietarySaturatedFatRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietarySaturatedFatRecord> deleteInTimeRange({
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
