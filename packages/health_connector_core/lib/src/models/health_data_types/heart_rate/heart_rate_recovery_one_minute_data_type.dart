part of '../health_data_type.dart';

/// Heart rate recovery one minute health data type.
///
/// Tracks the reduction in heart rate from the peak exercise rate to the rate
/// one minute after exercising ended.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported.
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.heartRateRecoveryOneMinute`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartraterecoveryoneminute)
///
/// ## Capabilities
///
/// - Readable: Query heart rate recovery records
/// - Writeable: Write heart rate recovery records
/// - Aggregatable: Calculate avg, min, max heart rate recovery
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [HeartRateRecoveryOneMinuteRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class HeartRateRecoveryOneMinuteDataType
    extends HealthDataType<HeartRateRecoveryOneMinuteRecord, Frequency>
    implements
        ReadableHealthDataType<HeartRateRecoveryOneMinuteRecord>,
        ReadableByIdHealthDataType<HeartRateRecoveryOneMinuteRecord>,
        ReadableInTimeRangeHealthDataType<HeartRateRecoveryOneMinuteRecord>,
        WriteableHealthDataType<HeartRateRecoveryOneMinuteRecord>,
        AvgAggregatableHealthDataType<Frequency>,
        MinAggregatableHealthDataType<Frequency>,
        MaxAggregatableHealthDataType<Frequency>,
        DeletableByIdsHealthDataType<HeartRateRecoveryOneMinuteRecord>,
        DeletableInTimeRangeHealthDataType<HeartRateRecoveryOneMinuteRecord> {
  /// Creates a heart rate recovery one minute measurement data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeartRateRecoveryOneMinuteDataType();

  @override
  String get id => 'heart_rate_recovery_one_minute';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateRecoveryOneMinuteDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<HeartRateRecoveryOneMinuteRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateRecoveryOneMinuteRecord>
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

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
