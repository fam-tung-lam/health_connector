part of '../health_data_type.dart';

/// Heart rate measurement data type.
///
/// Represents individual heart rate measurements in beats per minute (BPM).
/// Each measurement is a discrete reading typically taken at a specific point
/// in time.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (beats per minute).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.heartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)
/// - **Android Health Connect**: Use [HeartRateSeriesDataType]
/// instead
///
/// ## Capabilities
///
/// - Readable: Query heart rate measurements
/// - Writeable: Write heart rate measurements
/// - Aggregatable: Calculate avg, min, max heart rate
/// - Deletable: Delete records by IDs or time range
///
/// ## Platform Notes
///
/// On iOS, heart rate data is stored as individual measurement samples. Each
/// record has its own UUID and can be queried independently.
///
/// ## See also
///
/// - [HeartRateRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class HeartRateDataType extends HealthDataType<HeartRateRecord, Number>
    implements
        ReadableHealthDataType<HeartRateRecord>,
        WriteableHealthDataType<HeartRateRecord>,
        AvgAggregatableHealthDataType<HeartRateRecord, Number>,
        MinAggregatableHealthDataType<HeartRateRecord, Number>,
        MaxAggregatableHealthDataType<HeartRateRecord, Number>,
        DeletableHealthDataType<HeartRateRecord> {
  /// Creates a heart rate measurement data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeartRateDataType();

  @override
  String get id => 'heart_rate';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<HeartRateRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateRecord> readInTimeRange({
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
  AggregateRequest<HeartRateRecord, Number> aggregateAvg({
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
  AggregateRequest<HeartRateRecord, Number> aggregateMin({
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
  AggregateRequest<HeartRateRecord, Number> aggregateMax({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest<HeartRateRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<HeartRateRecord> deleteInTimeRange({
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
