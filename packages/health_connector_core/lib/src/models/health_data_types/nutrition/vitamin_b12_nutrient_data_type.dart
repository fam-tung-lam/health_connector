part of '../health_data_type.dart';

/// Vitamin B12 (Cobalamin) nutrient data type.
///
/// Tracks dietary vitamin b12 (cobalamin) intake, a water-soluble vitamin
/// essential for red blood cell formation and neurological function.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminB12`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb12)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query vitamin b12 (cobalamin) intake records
/// - Writeable: Write vitamin b12 (cobalamin) intake records
/// - Aggregatable: Sum total vitamin b12 (cobalamin) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [VitaminB12NutrientRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminB12NutrientDataType
    extends VitaminNutrientDataType<VitaminB12NutrientRecord>
    implements
        ReadableHealthDataType<VitaminB12NutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminB12NutrientRecord, Mass>,
        DeletableHealthDataType<VitaminB12NutrientRecord> {
  /// Creates a vitamin b12 (cobalamin) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const VitaminB12NutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<VitaminB12NutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<VitaminB12NutrientRecord> readInTimeRange({
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
  AggregateRequest<VitaminB12NutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<VitaminB12NutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<VitaminB12NutrientRecord> deleteInTimeRange({
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
