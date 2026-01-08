part of '../health_data_type.dart';

/// Calcium nutrient data type.
///
/// Tracks dietary calcium intake, a mineral essential for bone health,
/// muscle function, and nerve transmission.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCalcium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query calcium intake records
/// - Writeable: Write calcium intake records
/// - Aggregatable: Sum total calcium intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [CalciumNutrientRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CalciumNutrientDataType
    extends MineralNutrientDataType<CalciumNutrientRecord>
    implements
        ReadableHealthDataType<CalciumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CalciumNutrientRecord, Mass>,
        DeletableHealthDataType<CalciumNutrientRecord> {
  /// Creates a calcium nutrient data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CalciumNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CalciumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CalciumNutrientRecord> readInTimeRange({
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
  AggregateRequest<CalciumNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<CalciumNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<CalciumNutrientRecord> deleteInTimeRange({
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
