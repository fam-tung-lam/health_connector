part of '../health_data_type.dart';

/// Systolic blood pressure data type.
///
/// Represents the systolic (upper) blood pressure value, measured during
/// the contraction phase of the heart cycle. This is an iOS-specific data type.
///
/// ## Measurement Unit
///
/// Values are measured in [Pressure] units (mmHg, kPa, etc.).
///
/// ## Platform Mapping
///
/// - **Android (Health Connect)**: Not supported (use
/// [BloodPressureHealthDataType])
/// - **iOS (HealthKit)**: `HKQuantityType(.bloodPressureSystolic)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query systolic blood pressure records
/// - ✅ Writeable: Write systolic blood pressure records
/// - ✅ Aggregatable: Calculate avg, min, max systolic pressure
/// - ✅ Deletable: Delete records by IDs or time range
///
/// > [!NOTE]
/// > This data type is only supported on iOS/HealthKit. For Android,
/// > use [BloodPressureHealthDataType] which includes both systolic and
/// diastolic values.
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class SystolicBloodPressureHealthDataType
    extends HealthDataType<SystolicBloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<SystolicBloodPressureRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure>,
        MinAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure>,
        MaxAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure>,
        DeletableHealthDataType<SystolicBloodPressureRecord> {
  /// Creates a systolic blood pressure data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SystolicBloodPressureHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystolicBloodPressureHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SystolicBloodPressureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SystolicBloodPressureRecord> readInTimeRange({
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
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  DeleteRecordsByIdsRequest<SystolicBloodPressureRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<SystolicBloodPressureRecord>
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
