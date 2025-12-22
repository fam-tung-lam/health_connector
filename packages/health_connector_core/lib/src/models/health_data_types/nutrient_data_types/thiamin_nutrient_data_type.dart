part of '../health_data_type.dart';

/// Thiamin (Vitamin B1) nutrient data type.
///
/// Tracks dietary thiamin (vitamin b1) intake, a water-soluble vitamin that
/// helps convert nutrients into energy.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryThiamin)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query thiamin (vitamin b1) intake records
/// - ✅ Writeable: Write thiamin (vitamin b1) intake records
/// - ✅ Aggregatable: Sum total thiamin (vitamin b1) intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ThiaminNutrientDataType
    extends VitaminNutrientDataType<ThiaminNutrientRecord>
    implements
        ReadableHealthDataType<ThiaminNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ThiaminNutrientRecord, Mass> {
  /// Creates a thiamin (vitamin b1) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ThiaminNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ThiaminNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ThiaminNutrientRecord> readInTimeRange({
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
  AggregateRequest<ThiaminNutrientRecord, Mass> aggregateSum({
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
