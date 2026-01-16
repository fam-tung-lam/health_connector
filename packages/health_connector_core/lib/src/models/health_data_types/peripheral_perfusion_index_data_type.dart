part of 'health_data_type.dart';

/// [HealthDataType] for [PeripheralPerfusionIndexRecord].
///
/// ## Supported Aggregation
///
/// - [AggregationMetric.avg]
/// - [AggregationMetric.min]
/// - [AggregationMetric.max]
@sinceV3_1_0
@immutable
final class PeripheralPerfusionIndexDataType
    extends HealthDataType<PeripheralPerfusionIndexRecord, Percentage>
    implements
        ReadableHealthDataType<PeripheralPerfusionIndexRecord>,
        WriteableHealthDataType<PeripheralPerfusionIndexRecord>,
        DeletableHealthDataType<PeripheralPerfusionIndexRecord>,
        AvgAggregatableHealthDataType<
          PeripheralPerfusionIndexRecord,
          Percentage
        >,
        MinAggregatableHealthDataType<
          PeripheralPerfusionIndexRecord,
          Percentage
        >,
        MaxAggregatableHealthDataType<
          PeripheralPerfusionIndexRecord,
          Percentage
        > {
  /// Creates a [PeripheralPerfusionIndexDataType] instance.
  @internal
  const PeripheralPerfusionIndexDataType();

  @override
  String get id => 'peripheralPerfusionIndex';

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => const [
    HealthPlatform.appleHealth,
  ];

  @override
  ReadRecordByIdRequest<PeripheralPerfusionIndexRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PeripheralPerfusionIndexRecord>
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
  AggregateRequest<PeripheralPerfusionIndexRecord, Percentage> aggregateAvg({
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
  AggregateRequest<PeripheralPerfusionIndexRecord, Percentage> aggregateMin({
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
  AggregateRequest<PeripheralPerfusionIndexRecord, Percentage> aggregateMax({
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
  DeleteRecordsByIdsRequest<PeripheralPerfusionIndexRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<PeripheralPerfusionIndexRecord>
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
