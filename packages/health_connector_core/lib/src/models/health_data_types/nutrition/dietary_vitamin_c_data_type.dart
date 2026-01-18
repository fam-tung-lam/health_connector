part of '../health_data_type.dart';

/// Vitamin C (Ascorbic Acid) data type.
///
/// Tracks dietary vitamin c (ascorbic acid) intake, a water-soluble vitamin
/// that is a powerful antioxidant and supports immune system.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminC`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminc)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query vitamin c (ascorbic acid) intake records
/// - Writeable: Write vitamin c (ascorbic acid) intake records
/// - Aggregatable: Sum total vitamin c (ascorbic acid) intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryVitaminCRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminCDataType
    extends DietaryVitaminDataType<DietaryVitaminCRecord>
    implements
        ReadableByIdHealthDataType<DietaryVitaminCRecord>,
        ReadableInTimeRangeHealthDataType<DietaryVitaminCRecord>,
        WriteableHealthDataType<DietaryVitaminCRecord>,
        SumAggregatableHealthDataType<Mass>,
        DeletableByIdsHealthDataType<DietaryVitaminCRecord>,
        DeletableInTimeRangeHealthDataType<DietaryVitaminCRecord> {
  /// Creates a vitamin c (ascorbic acid) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryVitaminCDataType();

  @override
  String get id => 'dietary_vitamin_c';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryVitaminCRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryVitaminCRecord> readInTimeRange({
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
