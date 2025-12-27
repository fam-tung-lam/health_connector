part of 'health_data_type.dart';

/// Oxygen saturation data type.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`OxygenSaturationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.oxygenSaturation`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)
///
/// ## Capabilities
///
/// - Readable: Query oxygen saturation records
/// - Writeable: Write oxygen saturation records
/// - Aggregatable: Calculate avg, min, max oxygen saturation
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [OxygenSaturationRecord]
///
/// {@category Health Data Types}
@sinceV1_3_0
@immutable
final class OxygenSaturationHealthDataType
    extends HealthDataType<OxygenSaturationRecord, Percentage>
    implements
        ReadableHealthDataType<OxygenSaturationRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<OxygenSaturationRecord, Percentage>,
        MinAggregatableHealthDataType<OxygenSaturationRecord, Percentage>,
        MaxAggregatableHealthDataType<OxygenSaturationRecord, Percentage>,
        DeletableHealthDataType<OxygenSaturationRecord> {
  /// Creates an oxygen saturation data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const OxygenSaturationHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationHealthDataType &&
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
  ReadRecordByIdRequest<OxygenSaturationRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<OxygenSaturationRecord> readInTimeRange({
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
  AggregateRequest<OxygenSaturationRecord, Percentage> aggregateAvg({
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  DeleteRecordsByIdsRequest<OxygenSaturationRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<OxygenSaturationRecord> deleteInTimeRange({
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
