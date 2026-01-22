part of '../health_data_type.dart';

/// Running Ground Contact Time data type.
///
/// Tracks the amount of time the foot is in contact with the ground during
/// running. Lower ground contact times typically indicate more efficient
/// running form and can be used to analyze running technique.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.runningGroundContactTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runninggroundcontacttime)
///
/// ## Capabilities
///
/// - Readable: Query running ground contact time records
/// - Writeable: Write running ground contact time records
/// - Aggregatable: MIN, MAX, AVG ground contact time
/// - Deletable: Delete running ground contact time records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.runningGroundContactTime.readPermission,
///   HealthDataType.runningGroundContactTime.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.runningGroundContactTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   final milliseconds = record.groundContactTime.inMilliseconds;
///   print('Ground contact time: $milliseconds ms');
/// }
///
/// // Aggregate minimum ground contact time
/// final aggRequest = HealthDataType.runningGroundContactTime.aggregateMin(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Min contact time: ${aggResponse.value?.inMilliseconds} ms');
/// ```
///
/// ## See also
///
/// - [RunningGroundContactTimeRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class RunningGroundContactTimeDataType
    extends HealthDataType<RunningGroundContactTimeRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<RunningGroundContactTimeRecord>,
        ReadableInTimeRangeHealthDataType<RunningGroundContactTimeRecord>,
        WriteableHealthDataType<RunningGroundContactTimeRecord>,
        MinAggregatableHealthDataType<TimeDuration>,
        MaxAggregatableHealthDataType<TimeDuration>,
        AvgAggregatableHealthDataType<TimeDuration>,
        DeletableByIdsHealthDataType<RunningGroundContactTimeRecord>,
        DeletableInTimeRangeHealthDataType<RunningGroundContactTimeRecord> {
  /// Running ground contact time data type.
  @internal
  const RunningGroundContactTimeDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'running_ground_contact_time';

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
  ReadRecordByIdRequest<RunningGroundContactTimeRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RunningGroundContactTimeRecord>
  readInTimeRange({
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
  AggregateRequest<TimeDuration> aggregateMin({
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
  AggregateRequest<TimeDuration> aggregateMax({
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
  AggregateRequest<TimeDuration> aggregateAvg({
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
