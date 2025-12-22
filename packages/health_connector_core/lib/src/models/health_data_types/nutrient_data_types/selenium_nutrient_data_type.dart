part of '../health_data_type.dart';

/// Selenium nutrient data type.
///
/// Tracks dietary selenium intake, a trace mineral and antioxidant supporting
/// thyroid function.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietarySelenium)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query selenium intake records
/// - ✅ Writeable: Write selenium intake records
/// - ✅ Aggregatable: Sum total selenium intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SeleniumNutrientDataType
    extends MineralNutrientDataType<SeleniumNutrientRecord>
    implements
        ReadableHealthDataType<SeleniumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SeleniumNutrientRecord, Mass> {
  /// Creates a selenium nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SeleniumNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SeleniumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SeleniumNutrientRecord> readInTimeRange({
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
  AggregateRequest<SeleniumNutrientRecord, Mass> aggregateSum({
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
