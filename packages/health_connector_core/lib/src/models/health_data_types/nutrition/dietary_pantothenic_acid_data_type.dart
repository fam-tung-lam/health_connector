part of '../health_data_type.dart';

/// Pantothenic Acid (Vitamin B5) data type.
///
/// Tracks dietary pantothenic acid (vitamin b5) intake, a water-soluble vitamin
/// essential for synthesizing coenzyme A.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryPantothenicAcid`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query pantothenic acid (vitamin b5) intake records
/// - Writeable: Write pantothenic acid (vitamin b5) intake records
/// - Aggregatable: Sum total pantothenic acid (vitamin b5) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryPantothenicAcidRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryPantothenicAcidDataType
    extends DietaryVitaminDataType<DietaryPantothenicAcidRecord>
    implements
        ReadableByIdHealthDataType<DietaryPantothenicAcidRecord>,
        ReadableInTimeRangeHealthDataType<DietaryPantothenicAcidRecord>,
        WriteableHealthDataType<DietaryPantothenicAcidRecord>,
        SumAggregatableHealthDataType<Mass>,
        DeletableByIdsHealthDataType<DietaryPantothenicAcidRecord>,
        DeletableInTimeRangeHealthDataType<DietaryPantothenicAcidRecord> {
  /// Creates a pantothenic acid (vitamin b5) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryPantothenicAcidDataType();

  @override
  String get id => 'dietary_pantothenic_acid';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryPantothenicAcidRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryPantothenicAcidRecord> readInTimeRange({
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
