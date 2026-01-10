part of '../health_data_type.dart';

/// Total carbohydrate data type.
///
/// Tracks dietary total carbohydrate intake, a primary energy source for the
/// body.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query total carbohydrate intake records
/// - Writeable: Write total carbohydrate intake records
/// - Aggregatable: Sum total total carbohydrate intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryTotalCarbohydrateRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryTotalCarbohydrateDataType
    extends MacronutrientDataType<DietaryTotalCarbohydrateRecord>
    implements
        ReadableHealthDataType<DietaryTotalCarbohydrateRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DietaryTotalCarbohydrateRecord, Mass>,
        DeletableHealthDataType<DietaryTotalCarbohydrateRecord> {
  /// Creates a total carbohydrate data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryTotalCarbohydrateDataType();

  @override
  String get id => 'dietary_total_carbohydrate';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryTotalCarbohydrateDataType &&
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
  ReadRecordByIdRequest<DietaryTotalCarbohydrateRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryTotalCarbohydrateRecord>
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
  AggregateRequest<DietaryTotalCarbohydrateRecord, Mass> aggregateSum({
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
  DeleteRecordsByIdsRequest<DietaryTotalCarbohydrateRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryTotalCarbohydrateRecord>
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
