part of 'health_data_type.dart';

/// Health data type for Android heart rate series records.
///
/// **Platform:** Android only (Health Connect)
///
/// Heart rate series records on Android are container records with embedded
/// BPM samples. Each record has a single ID that encompasses all measurements.
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class HeartRateSeriesRecordHealthDataType
    extends HealthDataType<HeartRateSeriesRecord, Number>
    implements
        ReadableHealthDataType<HeartRateSeriesRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<HeartRateSeriesRecord, Number>,
        MinAggregatableHealthDataType<HeartRateSeriesRecord, Number>,
        MaxAggregatableHealthDataType<HeartRateSeriesRecord, Number> {
  @internal
  const HeartRateSeriesRecordHealthDataType();

  @override
  String get identifier => 'heart_rate_series_record';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateSeriesRecordHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'heart_rate_series_record_data_type';

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
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordByIdRequest<HeartRateSeriesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateSeriesRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

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
}
