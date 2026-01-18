part of 'health_data_type.dart';

/// Peripheral perfusion index data type.
///
/// Represents the peripheral perfusion index (PPI), which is a measure of the
/// peripheral blood flow.
///
/// ## Measurement Unit
///
/// Values are measured as [Percentage].
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.peripheralPerfusionIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peripheralperfusionindex)
///
/// ## Capabilities
///
/// - Readable: Query peripheral perfusion index records
/// - Writeable: Write peripheral perfusion index records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete peripheral perfusion index records by IDs or time range
///
/// ## See also
///
/// - [PeripheralPerfusionIndexRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class PeripheralPerfusionIndexDataType
    extends HealthDataType<PeripheralPerfusionIndexRecord, Percentage>
    implements
        ReadableHealthDataType<PeripheralPerfusionIndexRecord>,
        ReadableByIdHealthDataType<PeripheralPerfusionIndexRecord>,
        ReadableInTimeRangeHealthDataType<PeripheralPerfusionIndexRecord>,
        WriteableHealthDataType<PeripheralPerfusionIndexRecord>,
        DeletableByIdsHealthDataType<PeripheralPerfusionIndexRecord>,
        DeletableInTimeRangeHealthDataType<PeripheralPerfusionIndexRecord>,
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
  String get id => 'peripheral_perfusion_index';

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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
