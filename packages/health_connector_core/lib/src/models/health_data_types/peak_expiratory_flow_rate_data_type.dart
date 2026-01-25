part of 'health_data_type.dart';

/// Peak expiratory flow rate data type.
///
/// Peak Expiratory Flow Rate (PEFR) is the maximum flow rate generated during
/// a forceful exhalation. These samples use volume/time units (liters per second)
/// and measure discrete values.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.peakExpiratoryFlowRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peakexpiratoryflowrate)
///
/// ## Capabilities
///
/// - Readable: Query peak expiratory flow rate records
/// - Writeable: Write peak expiratory flow rate records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete peak expiratory flow rate records by IDs or time range
///
/// ## See also
///
/// - [PeakExpiratoryFlowRateRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@immutable
final class PeakExpiratoryFlowRateDataType
    extends HealthDataType<PeakExpiratoryFlowRateRecord, Volume>
    implements
        ReadableHealthDataType<PeakExpiratoryFlowRateRecord>,
        ReadableByIdHealthDataType<PeakExpiratoryFlowRateRecord>,
        ReadableInTimeRangeHealthDataType<PeakExpiratoryFlowRateRecord>,
        WriteableHealthDataType<PeakExpiratoryFlowRateRecord>,
        DeletableByIdsHealthDataType<PeakExpiratoryFlowRateRecord>,
        DeletableInTimeRangeHealthDataType<PeakExpiratoryFlowRateRecord>,
        AvgAggregatableHealthDataType<Volume>,
        MinAggregatableHealthDataType<Volume>,
        MaxAggregatableHealthDataType<Volume> {
  /// Creates a peak expiratory flow rate data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PeakExpiratoryFlowRateDataType();

  @override
  String get id => 'peak_expiratory_flow_rate';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeakExpiratoryFlowRateDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

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
  ReadRecordByIdRequest<PeakExpiratoryFlowRateRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PeakExpiratoryFlowRateRecord> readInTimeRange({
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

  @override
  AggregateRequest<Volume> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Volume> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Volume> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
