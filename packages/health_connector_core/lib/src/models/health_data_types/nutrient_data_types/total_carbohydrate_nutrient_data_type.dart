part of '../health_data_type.dart';

/// Total carbohydrate nutrient data type.
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
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryTotalCarbs)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query total carbohydrate intake records
/// - ✅ Writeable: Write total carbohydrate intake records
/// - ✅ Aggregatable: Sum total total carbohydrate intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class TotalCarbohydrateNutrientDataType
    extends MacronutrientDataType<TotalCarbohydrateNutrientRecord>
    implements
        ReadableHealthDataType<TotalCarbohydrateNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<TotalCarbohydrateNutrientRecord, Mass> {
  /// Creates a total carbohydrate nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const TotalCarbohydrateNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCarbohydrateNutrientDataType &&
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
  ReadRecordByIdRequest<TotalCarbohydrateNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<TotalCarbohydrateNutrientRecord>
  readInTimeRange({
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
  AggregateRequest<TotalCarbohydrateNutrientRecord, Mass> aggregateSum({
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
