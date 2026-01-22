part of 'health_data_type.dart';

/// Steps cadence series data type.
///
/// Represents steps cadence measurements as a series of samples over a time
/// interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`StepsCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsCadenceRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query steps cadence series records
/// - Writeable: Write steps cadence series records
/// - Aggregatable: Avg, Min, Max
///
/// ## See also
///
/// - [StepsCadenceSeriesRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnHealthConnect
final class StepsCadenceSeriesDataType
    extends HealthDataType<StepsCadenceSeriesRecord, Frequency>
    implements
        ReadableByIdHealthDataType<StepsCadenceSeriesRecord>,
        ReadableInTimeRangeHealthDataType<StepsCadenceSeriesRecord>,
        WriteableHealthDataType<StepsCadenceSeriesRecord>,
        AvgAggregatableHealthDataType<Frequency>,
        MinAggregatableHealthDataType<Frequency>,
        MaxAggregatableHealthDataType<Frequency>,
        DeletableByIdsHealthDataType<StepsCadenceSeriesRecord>,
        DeletableInTimeRangeHealthDataType<StepsCadenceSeriesRecord> {
  /// Creates a steps cadence series data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
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
  AggregateRequest<Frequency> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Frequency> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Frequency> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
