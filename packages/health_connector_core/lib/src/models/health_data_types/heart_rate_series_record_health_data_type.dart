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
    extends HealthDataType<HeartRateSeriesRecord, Numeric>
    implements
        ReadableHealthDataType<HeartRateSeriesRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<HeartRateSeriesRecord, Numeric>,
        MinAggregatableHealthDataType<HeartRateSeriesRecord, Numeric>,
        MaxAggregatableHealthDataType<HeartRateSeriesRecord, Numeric> {
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

  // ReadableHealthDataType implementation
  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<HeartRateSeriesRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<HeartRateSeriesRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  // WriteableHealthDataType implementation
  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  // AvgAggregatableHealthDataType implementation
  @override
  AggregateRequest<HeartRateSeriesRecord, Numeric> aggregateAverage({
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

  // MinAggregatableHealthDataType implementation
  @override
  AggregateRequest<HeartRateSeriesRecord, Numeric> aggregateMin({
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

  // MaxAggregatableHealthDataType implementation
  @override
  AggregateRequest<HeartRateSeriesRecord, Numeric> aggregateMax({
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
