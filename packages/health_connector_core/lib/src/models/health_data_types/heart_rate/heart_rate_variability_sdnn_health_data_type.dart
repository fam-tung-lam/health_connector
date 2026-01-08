part of '../health_data_type.dart';

/// Heart rate variability (SDNN) data type.
///
/// Tracks heart rate variability using the SDNN (Standard Deviation of NN
/// intervals) metric. SDNN measures the standard deviation of the time
/// intervals between consecutive heartbeats, providing insight into the
/// autonomic nervous system's regulation of heart rate. Higher values
/// generally indicate better cardiovascular fitness and stress resilience.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] representing milliseconds.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.heartRateVariabilitySDNN`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn)
///
/// ## Capabilities
///
/// - Readable: Query HRV SDNN records
/// - Writeable: Write HRV SDNN records
/// - Aggregatable: Calculate min, max, avg, and sum of HRV values
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [HeartRateVariabilitySDNNRecord]
/// - [HeartRateVariabilityRMSSDDataType] for RMSSD metric
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class HeartRateVariabilitySDNNDataType
    extends HealthDataType<HeartRateVariabilitySDNNRecord, Number>
    implements
        MinAggregatableHealthDataType<HeartRateVariabilitySDNNRecord, Number>,
        MaxAggregatableHealthDataType<HeartRateVariabilitySDNNRecord, Number>,
        AvgAggregatableHealthDataType<HeartRateVariabilitySDNNRecord, Number>,
        SumAggregatableHealthDataType<HeartRateVariabilitySDNNRecord, Number>,
        ReadableHealthDataType<HeartRateVariabilitySDNNRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<HeartRateVariabilitySDNNRecord> {
  /// Creates a heart rate variability (SDNN) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeartRateVariabilitySDNNDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
    AggregationMetric.sum,
  ];

  @override
  AggregateRequest<HeartRateVariabilitySDNNRecord, Number> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.min,
    );
  }

  @override
  AggregateRequest<HeartRateVariabilitySDNNRecord, Number> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.max,
    );
  }

  @override
  AggregateRequest<HeartRateVariabilitySDNNRecord, Number> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.avg,
    );
  }

  @override
  AggregateRequest<HeartRateVariabilitySDNNRecord, Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.sum,
    );
  }

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  ReadRecordByIdRequest<HeartRateVariabilitySDNNRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateVariabilitySDNNRecord>
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
  DeleteRecordsByIdsRequest<HeartRateVariabilitySDNNRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<HeartRateVariabilitySDNNRecord>
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
