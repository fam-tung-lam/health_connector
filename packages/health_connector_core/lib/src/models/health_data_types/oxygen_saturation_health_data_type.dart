part of 'health_data_type.dart';

/// Oxygen saturation data type.
@sinceV1_0_0
@immutable
final class OxygenSaturationHealthDataType
    extends HealthDataType<OxygenSaturationRecord, Percentage>
    implements
        ReadableHealthDataType<OxygenSaturationRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<OxygenSaturationRecord, Percentage>,
        MinAggregatableHealthDataType<OxygenSaturationRecord, Percentage>,
        MaxAggregatableHealthDataType<OxygenSaturationRecord, Percentage> {
  @internal
  const OxygenSaturationHealthDataType();

  @override
  String get identifier => 'oxygen_saturation';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'oxygen_saturation_data_type';

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
  ReadRecordRequest<OxygenSaturationRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<OxygenSaturationRecord> readRecords({
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
  AggregateRequest<OxygenSaturationRecord, Percentage> aggregateAverage({
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
  AggregateRequest<OxygenSaturationRecord, Percentage> aggregateMin({
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
  AggregateRequest<OxygenSaturationRecord, Percentage> aggregateMax({
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
