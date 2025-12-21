part of 'health_data_type.dart';

/// Blood glucose data type.
///
/// Represents the concentration of glucose in the blood.
/// Supports both reading existing blood glucose data and writing new
/// measurements.
/// Supports AVG, MIN, MAX aggregation.
@sinceV1_4_0
@immutable
final class BloodGlucoseHealthDataType
    extends HealthDataType<BloodGlucoseRecord, BloodGlucose>
    implements
        ReadableHealthDataType<BloodGlucoseRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose>,
        MinAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose>,
        MaxAggregatableHealthDataType<BloodGlucoseRecord, BloodGlucose> {
  const BloodGlucoseHealthDataType();

  @override
  String get identifier => 'blood_glucose';

  @override
  String get name => identifier;

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
}
