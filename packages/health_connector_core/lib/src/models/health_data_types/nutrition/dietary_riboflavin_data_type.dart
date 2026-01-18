part of '../health_data_type.dart';

/// Riboflavin (Vitamin B2) data type.
///
/// Tracks dietary riboflavin (vitamin b2) intake, a water-soluble vitamin
/// supporting cellular function and energy production.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryRiboflavin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query riboflavin (vitamin b2) intake records
/// - Writeable: Write riboflavin (vitamin b2) intake records
/// - Aggregatable: Sum total riboflavin (vitamin b2) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryRiboflavinRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryRiboflavinDataType
    extends DietaryVitaminDataType<DietaryRiboflavinRecord>
    implements
        ReadableByIdHealthDataType<DietaryRiboflavinRecord>,
        ReadableInTimeRangeHealthDataType<DietaryRiboflavinRecord>,
        WriteableHealthDataType<DietaryRiboflavinRecord>,
        SumAggregatableHealthDataType<DietaryRiboflavinRecord, Mass>,
        DeletableByIdsHealthDataType<DietaryRiboflavinRecord>,
        DeletableInTimeRangeHealthDataType<DietaryRiboflavinRecord> {
  /// Creates a riboflavin (vitamin b2) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryRiboflavinDataType();

  @override
  String get id => 'dietary_riboflavin';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryRiboflavinRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryRiboflavinRecord> readInTimeRange({
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
  AggregateRequest<DietaryRiboflavinRecord, Mass> aggregateSum({
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
