part of 'health_data_type.dart';

/// Respiratory rate data type.
@sinceV1_3_0
@immutable
final class RespiratoryRateHealthDataType
    extends HealthDataType<RespiratoryRateRecord, RespiratoryRate>
    implements
        ReadableHealthDataType<RespiratoryRateRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<RespiratoryRateRecord, RespiratoryRate>,
        MinAggregatableHealthDataType<RespiratoryRateRecord, RespiratoryRate>,
        MaxAggregatableHealthDataType<RespiratoryRateRecord, RespiratoryRate> {
  @internal
  const RespiratoryRateHealthDataType();

  @override
  String get identifier => 'respiratory_rate';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'respiratory_rate_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<RespiratoryRateRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<RespiratoryRateRecord> readRecords({
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

  @override
  AggregateRequest<RespiratoryRateRecord, RespiratoryRate> aggregateAvg({
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
  AggregateRequest<RespiratoryRateRecord, RespiratoryRate> aggregateMin({
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
  AggregateRequest<RespiratoryRateRecord, RespiratoryRate> aggregateMax({
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
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
