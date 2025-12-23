part of 'health_data_type.dart';

/// Body height data type.
///
/// Represents body height measurements, typically used for tracking growth
/// in children, calculating BMI, and monitoring overall health metrics.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters, centimeters, feet, inches,
/// etc.).
///
/// ## Platform Mapping
///
/// - **Android (Health Connect)**: `HeightRecord`
/// - **iOS (HealthKit)**: `HKQuantityType(.height)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query height records
/// - ✅ Writeable: Write height records
/// - ✅ Aggregatable: Calculate avg, min, max height
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV1_0_0
@immutable
final class HeightHealthDataType extends HealthDataType<HeightRecord, Length>
    implements
        ReadableHealthDataType<HeightRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<HeightRecord, Length>,
        MinAggregatableHealthDataType<HeightRecord, Length>,
        MaxAggregatableHealthDataType<HeightRecord, Length>,
        DeletableHealthDataType<HeightRecord> {
  /// Creates a height data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeightHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightHealthDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<HeightRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeightRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<HeightRecord, Length> aggregateAvg({
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
  AggregateRequest<HeightRecord, Length> aggregateMin({
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
  AggregateRequest<HeightRecord, Length> aggregateMax({
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
  DeleteRecordsByIdsRequest<HeightRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<HeightRecord> deleteInTimeRange({
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
