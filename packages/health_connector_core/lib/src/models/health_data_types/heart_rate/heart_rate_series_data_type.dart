part of '../health_data_type.dart';

/// Health data type for Android heart rate series records.
///
/// Heart rate series records on Android are container records with embedded
/// BPM samples. Each record has a single ID that encompasses all measurements.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateRecord)
/// - **iOS HealthKit**: Not supported (iOS uses discrete
///   [HeartRateDataType] samples)
///
/// ## Capabilities
///
/// - Readable: Query heart rate series
/// - Writeable: Write heart rate series
/// - Aggregatable: Calculate avg, min, max heart rate
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [HeartRateSeriesRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class HeartRateSeriesDataType
    extends HealthDataType<HeartRateSeriesRecord, Number>
    implements
        ReadableHealthDataType<HeartRateSeriesRecord>,
        WriteableHealthDataType<HeartRateSeriesRecord>,
        AvgAggregatableHealthDataType<HeartRateSeriesRecord, Number>,
        MinAggregatableHealthDataType<HeartRateSeriesRecord, Number>,
        MaxAggregatableHealthDataType<HeartRateSeriesRecord, Number>,
        DeletableHealthDataType<HeartRateSeriesRecord> {
  /// Creates a heart rate series data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeartRateSeriesDataType();

  @override
  String get id => 'heart_rate_series';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateSeriesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

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
  ReadRecordByIdRequest<HeartRateSeriesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateSeriesRecord> readInTimeRange({
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
  AggregateRequest<HeartRateSeriesRecord, Number> aggregateAvg({
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
  AggregateRequest<HeartRateSeriesRecord, Number> aggregateMin({
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
  AggregateRequest<HeartRateSeriesRecord, Number> aggregateMax({
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
  DeleteRecordsByIdsRequest<HeartRateSeriesRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<HeartRateSeriesRecord> deleteInTimeRange({
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
