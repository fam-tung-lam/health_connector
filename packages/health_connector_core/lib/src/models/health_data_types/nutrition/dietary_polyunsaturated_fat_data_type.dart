part of '../health_data_type.dart';

/// Polyunsaturated fat data type.
///
/// Tracks dietary polyunsaturated fat intake, a healthy fat including omega-3
/// and omega-6 fatty acids.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatPolyunsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query polyunsaturated fat intake records
/// - Writeable: Write polyunsaturated fat intake records
/// - Aggregatable: Sum total polyunsaturated fat intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryPolyunsaturatedFatRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryPolyunsaturatedFatDataType
    extends MacronutrientDataType<DietaryPolyunsaturatedFatRecord>
    implements
        ReadableHealthDataType<DietaryPolyunsaturatedFatRecord>,
        WriteableHealthDataType<DietaryPolyunsaturatedFatRecord>,
        SumAggregatableHealthDataType<DietaryPolyunsaturatedFatRecord, Mass>,
        DeletableHealthDataType<DietaryPolyunsaturatedFatRecord> {
  /// Creates a polyunsaturated fat data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryPolyunsaturatedFatDataType();

  @override
  String get id => 'dietary_polyunsaturated_fat';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryPolyunsaturatedFatDataType &&
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
  ReadRecordByIdRequest<DietaryPolyunsaturatedFatRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryPolyunsaturatedFatRecord>
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
  AggregateRequest<DietaryPolyunsaturatedFatRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietaryPolyunsaturatedFatRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryPolyunsaturatedFatRecord>
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
