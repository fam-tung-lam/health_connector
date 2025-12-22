part of '../health_data_type.dart';

/// Pantothenic Acid (Vitamin B5) nutrient data type.
///
/// Tracks dietary pantothenic acid (vitamin b5) intake, a water-soluble vitamin
/// essential for synthesizing coenzyme A.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.dietaryPantothenicAcid)`
/// - **Android (Health Connect)**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query pantothenic acid (vitamin b5) intake records
/// - ✅ Writeable: Write pantothenic acid (vitamin b5) intake records
/// - ✅ Aggregatable: Sum total pantothenic acid (vitamin b5) intake
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PantothenicAcidNutrientDataType
    extends VitaminNutrientDataType<PantothenicAcidNutrientRecord>
    implements
        ReadableHealthDataType<PantothenicAcidNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PantothenicAcidNutrientRecord, Mass> {
  /// Creates a pantothenic acid (vitamin b5) nutrient data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PantothenicAcidNutrientDataType();

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PantothenicAcidNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PantothenicAcidNutrientRecord> readInTimeRange({
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
  AggregateRequest<PantothenicAcidNutrientRecord, Mass> aggregateSum({
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
