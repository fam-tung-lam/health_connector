part of 'health_data_type.dart';

/// Respiratory rate data type.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`RespiratoryRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.respiratoryRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)
///
/// ## Capabilities
///
/// - Readable: Query respiratory rate records
/// - Writeable: Write respiratory rate records
/// - Aggregatable: Calculate avg, min, max respiratory rate
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [RespiratoryRateRecord]
///
/// {@category Health Data Types}
@sinceV1_3_0
@immutable
final class RespiratoryRateHealthDataType
    extends HealthDataType<RespiratoryRateRecord, Number>
    implements
        ReadableHealthDataType<RespiratoryRateRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<RespiratoryRateRecord, Number>,
        MinAggregatableHealthDataType<RespiratoryRateRecord, Number>,
        MaxAggregatableHealthDataType<RespiratoryRateRecord, Number>,
        DeletableHealthDataType<RespiratoryRateRecord> {
  /// Creates a respiratory rate data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const RespiratoryRateHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateHealthDataType &&
          runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<RespiratoryRateRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RespiratoryRateRecord> readInTimeRange({
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
  AggregateRequest<RespiratoryRateRecord, Number> aggregateAvg({
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
  AggregateRequest<RespiratoryRateRecord, Number> aggregateMin({
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
  AggregateRequest<RespiratoryRateRecord, Number> aggregateMax({
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest<RespiratoryRateRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<RespiratoryRateRecord> deleteInTimeRange({
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
