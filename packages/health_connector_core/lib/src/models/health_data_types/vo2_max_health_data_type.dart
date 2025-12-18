part of 'health_data_type.dart';

/// Health data type for VO₂ max (maximal oxygen uptake) measurements.
///
/// VO₂ max is the maximum rate of oxygen consumption measured during
/// incremental exercise and is a key indicator of cardiorespiratory fitness.
@sinceV1_3_0
@immutable
final class Vo2MaxHealthDataType extends HealthDataType<Vo2MaxRecord, Vo2Max>
    implements
        ReadableHealthDataType<Vo2MaxRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<Vo2MaxRecord, Vo2Max>,
        MinAggregatableHealthDataType<Vo2MaxRecord, Vo2Max>,
        MaxAggregatableHealthDataType<Vo2MaxRecord, Vo2Max> {
  @internal
  const Vo2MaxHealthDataType();

  @override
  String get identifier => 'vo2_max';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2MaxHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'vo2_max_data_type';

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
  ReadRecordRequest<Vo2MaxRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<Vo2MaxRecord> readRecords({
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
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  AggregateRequest<Vo2MaxRecord, Vo2Max> aggregateAvg({
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
  AggregateRequest<Vo2MaxRecord, Vo2Max> aggregateMin({
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
  AggregateRequest<Vo2MaxRecord, Vo2Max> aggregateMax({
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
