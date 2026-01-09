part of '../health_data_type.dart';

/// Biotin (Vitamin B7) nutrient data type.
///
/// Tracks dietary biotin (vitamin b7) intake, a water-soluble vitamin
/// supporting hair, skin, and nail health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryBiotin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query biotin (vitamin b7) intake records
/// - Writeable: Write biotin (vitamin b7) intake records
/// - Aggregatable: Sum total biotin (vitamin b7) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BiotinNutrientRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class BiotinNutrientDataType
    extends VitaminNutrientDataType<BiotinNutrientRecord>
    implements
        ReadableHealthDataType<BiotinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<BiotinNutrientRecord, Mass>,
        DeletableHealthDataType<BiotinNutrientRecord> {
  /// Creates a biotin (vitamin b7) nutrient data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BiotinNutrientDataType();

  @override
  String get id => 'biotin_nutrient';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BiotinNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BiotinNutrientRecord> readInTimeRange({
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
  AggregateRequest<BiotinNutrientRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<BiotinNutrientRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BiotinNutrientRecord> deleteInTimeRange({
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
