part of 'health_data_type.dart';

/// VO₂ max data type.
///
/// Represents the maximal oxygen uptake, the maximum rate of oxygen consumption
/// measured during incremental exercise. VO₂ max is considered the gold
/// standard
/// for measuring cardiorespiratory fitness and aerobic endurance.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`Vo2MaxRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.vo2Max`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)
///
/// ## Capabilities
///
/// - Readable: Query VO₂ max records
/// - Writeable: Write VO₂ max records
/// - Aggregatable: Calculate avg, min, max VO₂ max
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [Vo2MaxRecord]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class Vo2MaxDataType extends HealthDataType<Vo2MaxRecord, Number>
    implements
        ReadableByIdHealthDataType<Vo2MaxRecord>,
        ReadableInTimeRangeHealthDataType<Vo2MaxRecord>,
        WriteableHealthDataType<Vo2MaxRecord>,
        AvgAggregatableHealthDataType<Number>,
        MinAggregatableHealthDataType<Number>,
        MaxAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<Vo2MaxRecord>,
        DeletableInTimeRangeHealthDataType<Vo2MaxRecord> {
  /// Creates a VO₂ max data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const Vo2MaxDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'vo2_max';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2MaxDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<Vo2MaxRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<Vo2MaxRecord> readInTimeRange({
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<Number> aggregateAvg({
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
  AggregateRequest<Number> aggregateMin({
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
  AggregateRequest<Number> aggregateMax({
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

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
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
