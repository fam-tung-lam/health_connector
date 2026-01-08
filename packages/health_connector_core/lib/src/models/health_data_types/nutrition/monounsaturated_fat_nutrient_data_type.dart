part of '../health_data_type.dart';

/// Monounsaturated fat nutrient data type.
///
/// Tracks dietary monounsaturated fat intake, a healthy fat beneficial for
/// heart health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatMonounsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatmonounsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query monounsaturated fat intake records
/// - Writeable: Write monounsaturated fat intake records
/// - Aggregatable: Sum total monounsaturated fat intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [MonounsaturatedFatNutrientRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class MonounsaturatedFatNutrientDataType
    extends MacronutrientDataType<MonounsaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<MonounsaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<MonounsaturatedFatNutrientRecord, Mass>,
        DeletableHealthDataType<MonounsaturatedFatNutrientRecord> {
  /// Creates a monounsaturated fat nutrient data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const MonounsaturatedFatNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonounsaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MonounsaturatedFatNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MonounsaturatedFatNutrientRecord>
  readInTimeRange({
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
  AggregateRequest<MonounsaturatedFatNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<MonounsaturatedFatNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<MonounsaturatedFatNutrientRecord>
  deleteInTimeRange({
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
