part of '../health_data_type.dart';

/// Health data type for resting heart rate information.
///
/// Resting heart rate represents the heart rate while at complete rest,
/// typically measured first thing in the morning before getting out of bed.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`RestingHeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.restingHeartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)
///
/// ## Capabilities
///
/// - Readable: Query resting heart rate records
/// - Writeable: Write resting heart rate records
/// - Aggregatable: Calculate avg, min, max resting heart rate
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [RestingHeartRateRecord]
///
/// {@category Health Data Types}
@sinceV1_3_0
@immutable
final class RestingHeartRateHealthDataType
    extends HealthDataType<RestingHeartRateRecord, Number>
    implements
        ReadableHealthDataType<RestingHeartRateRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<RestingHeartRateRecord, Number>,
        MinAggregatableHealthDataType<RestingHeartRateRecord, Number>,
        MaxAggregatableHealthDataType<RestingHeartRateRecord, Number>,
        DeletableHealthDataType<RestingHeartRateRecord> {
  /// Creates a resting heart rate data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const RestingHeartRateHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateHealthDataType &&
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
  ReadRecordByIdRequest<RestingHeartRateRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RestingHeartRateRecord> readInTimeRange({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateAvg({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateMin({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateMax({
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
  DeleteRecordsByIdsRequest<RestingHeartRateRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<RestingHeartRateRecord> deleteInTimeRange({
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
