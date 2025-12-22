part of '../health_data_type.dart';

/// Vitamin K nutrient data type.
///
/// Tracks dietary vitamin k intake, a fat-soluble vitamin necessary for blood
/// clotting and bone health.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (micrograms typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryVitaminK)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query vitamin k intake records
/// - ✅ Writeable: Write vitamin k intake records
/// - ✅ Aggregatable: Sum total vitamin k intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminKNutrientDataType
    extends VitaminNutrientDataType<VitaminKNutrientRecord>
    implements
        ReadableHealthDataType<VitaminKNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminKNutrientRecord, Mass> {
  /// Creates a vitamin k nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const VitaminKNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<VitaminKNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<VitaminKNutrientRecord> readInTimeRange({
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
  AggregateRequest<VitaminKNutrientRecord, Mass> aggregateSum({
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
