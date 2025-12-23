part of 'health_data_type.dart';

/// Blood glucose data type.
///
/// Represents the concentration of glucose in the blood, commonly measured
/// for diabetes management and metabolic health tracking. Blood glucose records
/// include context such as meal relation, specimen source, and measurement
/// type.
///
/// ## Measurement Unit
///
/// Values are measured in [BloodGlucose] units (mg/dL or mmol/L).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `BloodGlucoseRecord`
/// - **iOS HealthKit**: `HKQuantityType(.bloodGlucose)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query blood glucose records
/// - ✅ Writeable: Write blood glucose records
/// - ✅ Aggregatable: Calculate avg, min, max blood glucose
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_4_0
@immutable
final class BloodGlucoseHealthDataType
    extends HealthDataType<BloodGlucoseRecord, BloodGlucose>
    implements
        ReadableHealthDataType<BloodGlucoseRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose>,
        MinAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose>,
        MaxAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose>,
        DeletableHealthDataType<BloodGlucoseRecord> {
  /// Creates a blood glucose data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  const BloodGlucoseHealthDataType();

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BloodGlucoseRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BloodGlucoseRecord> readInTimeRange({
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
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  AggregateRequest<BloodGlucoseRecord, BloodGlucose> aggregateAvg({
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
  AggregateRequest<BloodGlucoseRecord, BloodGlucose> aggregateMax({
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
  AggregateRequest<BloodGlucoseRecord, BloodGlucose> aggregateMin({
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
  DeleteRecordsByIdsRequest<BloodGlucoseRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BloodGlucoseRecord> deleteInTimeRange({
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
