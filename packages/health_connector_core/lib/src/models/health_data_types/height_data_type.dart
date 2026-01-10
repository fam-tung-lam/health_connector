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
/// - **Android Health Connect**: [`HeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeightRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.height`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/height)
///
/// ## Capabilities
///
/// - Readable: Query height records
/// - Writeable: Write height records
/// - Aggregatable: Calculate avg, min, max height
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [HeightRecord]
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class HeightDataType extends HealthDataType<HeightRecord, Length>
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
  const HeightDataType();

  @override
  String get id => 'height';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightDataType && runtimeType == other.runtimeType;

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
  HealthDataTypeCategory get category => HealthDataTypeCategory.bodyMeasurement;

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
