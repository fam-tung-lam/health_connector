part of '../health_data_type.dart';

/// Protein data type.
///
/// Tracks dietary protein intake, a macronutrient essential for muscle growth,
/// repair, and overall body function.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryProtein`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query protein intake records
/// - Writeable: Write protein intake records
/// - Aggregatable: Sum total protein intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryProteinRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryProteinDataType
    extends MacronutrientDataType<DietaryProteinRecord>
    implements
        ReadableByIdHealthDataType<DietaryProteinRecord>,
        ReadableInTimeRangeHealthDataType<DietaryProteinRecord>,
        WriteableHealthDataType<DietaryProteinRecord>,
        SumAggregatableHealthDataType<Mass>,
        DeletableByIdsHealthDataType<DietaryProteinRecord>,
        DeletableInTimeRangeHealthDataType<DietaryProteinRecord> {
  /// Creates a protein data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryProteinDataType();

  @override
  String get id => 'dietary_protein';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryProteinDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryProteinRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryProteinRecord> readInTimeRange({
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
    return StandardAggregateRequest(
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
