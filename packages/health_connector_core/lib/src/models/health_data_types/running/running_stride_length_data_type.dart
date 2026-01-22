part of '../health_data_type.dart';

/// Running Stride Length data type.
///
/// Tracks the distance covered by a single step while running.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.runningStrideLength`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningstridelength)
///
/// ## Capabilities
///
/// - Readable: Query running stride length records
/// - Writeable: Write running stride length records
/// - Aggregatable: MIN, MAX, AVG stride length
/// - Deletable: Delete running stride length records by IDs or time range
///
/// ## See also
///
/// - [RunningStrideLengthRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class RunningStrideLengthDataType
    extends HealthDataType<RunningStrideLengthRecord, Length>
    implements
        ReadableByIdHealthDataType<RunningStrideLengthRecord>,
        ReadableInTimeRangeHealthDataType<RunningStrideLengthRecord>,
        WriteableHealthDataType<RunningStrideLengthRecord>,
        MinAggregatableHealthDataType<Length>,
        MaxAggregatableHealthDataType<Length>,
        AvgAggregatableHealthDataType<Length>,
        DeletableByIdsHealthDataType<RunningStrideLengthRecord>,
        DeletableInTimeRangeHealthDataType<RunningStrideLengthRecord> {
  /// Running stride length data type.
  @internal
  const RunningStrideLengthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'running_stride_length';

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.max,
    AggregationMetric.min,
    AggregationMetric.avg,
  ];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  ReadRecordByIdRequest<RunningStrideLengthRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RunningStrideLengthRecord> readInTimeRange({
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
  AggregateRequest<Length> aggregateMin({
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
  AggregateRequest<Length> aggregateMax({
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
  AggregateRequest<Length> aggregateAvg({
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

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
