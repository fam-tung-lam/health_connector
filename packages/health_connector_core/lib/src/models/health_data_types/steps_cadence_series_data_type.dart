part of 'health_data_type.dart';

/// Steps cadence series data type (Android Health Connect only).
///
/// Represents steps cadence measurements as a series of samples over a time
/// interval.
@sinceV3_1_0
@supportedOnHealthConnect
final class StepsCadenceSeriesDataType
    extends HealthDataType<StepsCadenceSeriesRecord, Frequency>
    implements
        ReadableHealthDataType<StepsCadenceSeriesRecord>,
        WriteableHealthDataType<StepsCadenceSeriesRecord>,
        AvgAggregatableHealthDataType<StepsCadenceSeriesRecord, Frequency>,
        MinAggregatableHealthDataType<StepsCadenceSeriesRecord, Frequency>,
        MaxAggregatableHealthDataType<StepsCadenceSeriesRecord, Frequency> {
  /// Default constructor.
  const StepsCadenceSeriesDataType();

  @override
  String get id => 'steps_cadence_series';

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  ReadRecordByIdRequest<StepsCadenceSeriesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<StepsCadenceSeriesRecord> readInTimeRange({
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
  AggregateRequest<StepsCadenceSeriesRecord, Frequency> aggregateAvg({
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
  AggregateRequest<StepsCadenceSeriesRecord, Frequency> aggregateMin({
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
  AggregateRequest<StepsCadenceSeriesRecord, Frequency> aggregateMax({
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
}
