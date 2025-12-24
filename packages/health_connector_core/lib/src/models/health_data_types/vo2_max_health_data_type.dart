part of 'health_data_type.dart';

/// VO₂ max data type.
///
/// Represents the maximal oxygen uptake, the maximum rate of oxygen consumption
/// measured during incremental exercise. VO₂ max is considered the gold
/// standard
/// for measuring cardiorespiratory fitness and aerobic endurance.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (mL/kg/min - milliliters of oxygen per
/// kilogram of body weight per minute).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `Vo2MaxRecord`
/// - **iOS HealthKit**: `HKQuantityType(.vo2Max)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query VO₂ max records
/// - ✅ Writeable: Write VO₂ max records
/// - ✅ Aggregatable: Calculate avg, min, max VO₂ max
/// - ✅ Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV1_3_0
@immutable
final class Vo2MaxHealthDataType extends HealthDataType<Vo2MaxRecord, Number>
    implements
        ReadableHealthDataType<Vo2MaxRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<Vo2MaxRecord, Number>,
        MinAggregatableHealthDataType<Vo2MaxRecord, Number>,
        MaxAggregatableHealthDataType<Vo2MaxRecord, Number>,
        DeletableHealthDataType<Vo2MaxRecord> {
  /// Creates a VO₂ max data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const Vo2MaxHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2MaxHealthDataType && runtimeType == other.runtimeType;

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
  AggregateRequest<Vo2MaxRecord, Number> aggregateAvg({
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
  AggregateRequest<Vo2MaxRecord, Number> aggregateMin({
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
  AggregateRequest<Vo2MaxRecord, Number> aggregateMax({
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

  @override
  DeleteRecordsByIdsRequest<Vo2MaxRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<Vo2MaxRecord> deleteInTimeRange({
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
