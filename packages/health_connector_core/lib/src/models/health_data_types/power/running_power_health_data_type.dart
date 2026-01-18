part of '../health_data_type.dart';

/// Represents the running power health data type.
///
/// Running power estimates the effort exerted while running, measured in Watts.
///
/// ## Measurement Unit
///
/// Values are measured in [Power] units.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported.
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.runningPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningpower)
///
/// ## Capabilities
///
/// - Readable: Query running power records
/// - Writeable: Write running power records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete running power records by IDs or time range
///
/// ## See also
///
/// - [RunningPowerRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class RunningPowerDataType
    extends HealthDataType<RunningPowerRecord, Power>
    implements
        ReadableByIdHealthDataType<RunningPowerRecord>,
        ReadableInTimeRangeHealthDataType<RunningPowerRecord>,
        WriteableHealthDataType<RunningPowerRecord>,
        DeletableHealthDataType<RunningPowerRecord>,
        AvgAggregatableHealthDataType<RunningPowerRecord, Power>,
        MinAggregatableHealthDataType<RunningPowerRecord, Power>,
        MaxAggregatableHealthDataType<RunningPowerRecord, Power> {
  /// Creates a running power data type.
  const RunningPowerDataType._();

  @override
  String get id => 'running_power';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  ReadRecordByIdRequest<RunningPowerRecord> readById(HealthRecordId recordId) {
    return ReadRecordByIdRequest<RunningPowerRecord>(
      dataType: this,
      id: recordId,
    );
  }

  @override
  ReadRecordsInTimeRangeRequest<RunningPowerRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = 1000,
    String? pageToken,
    List<DataOrigin> dataOrigins = const [],
  }) {
    return ReadRecordsInTimeRangeRequest<RunningPowerRecord>(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
      dataOrigins: dataOrigins,
    );
  }

  @override
  HealthDataPermission get readPermission {
    return HealthDataPermission.read(this);
  }

  @override
  HealthDataPermission get writePermission {
    return HealthDataPermission.write(this);
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  DeleteRecordsByIdsRequest<RunningPowerRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest<RunningPowerRecord>(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<RunningPowerRecord> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return DeleteRecordsInTimeRangeRequest<RunningPowerRecord>(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<RunningPowerRecord, Power> aggregateAvg({
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
  AggregateRequest<RunningPowerRecord, Power> aggregateMin({
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
  AggregateRequest<RunningPowerRecord, Power> aggregateMax({
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
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RunningPowerDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
