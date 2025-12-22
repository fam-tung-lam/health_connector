part of '../health_data_type.dart';

/// Dietary fiber nutrient data type.
///
/// Tracks dietary dietary fiber intake, a indigestible carbohydrate important
/// for digestive health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (grams typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryFiber)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query dietary fiber intake records
/// - ✅ Writeable: Write dietary fiber intake records
/// - ✅ Aggregatable: Sum total dietary fiber intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryFiberNutrientDataType
    extends MacronutrientDataType<DietaryFiberNutrientRecord>
    implements
        ReadableHealthDataType<DietaryFiberNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DietaryFiberNutrientRecord, Mass> {
  /// Creates a dietary fiber nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryFiberNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryFiberNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryFiberNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryFiberNutrientRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<DietaryFiberNutrientRecord, Mass> aggregateSum({
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
}
