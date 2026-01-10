part of 'health_data_type.dart';

/// Body weight data type.
///
/// Represents body weight measurements, typically used for tracking body
/// composition changes, fitness progress, and health monitoring.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilograms, pounds, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`WeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)
///
/// ## Capabilities
///
/// - Readable: Query weight records
/// - Writeable: Write weight records
/// - Aggregatable: Calculate avg, min, max weight
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [WeightRecord]
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class WeightDataType extends HealthDataType<WeightRecord, Mass>
    implements
        ReadableHealthDataType<WeightRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<WeightRecord, Mass>,
        MinAggregatableHealthDataType<WeightRecord, Mass>,
        MaxAggregatableHealthDataType<WeightRecord, Mass>,
        DeletableHealthDataType<WeightRecord> {
  /// Creates a weight data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WeightDataType();

  @override
  String get id => 'weight';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<WeightRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WeightRecord> readInTimeRange({
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
  AggregateRequest<WeightRecord, Mass> aggregateAvg({
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
  AggregateRequest<WeightRecord, Mass> aggregateMin({
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
  AggregateRequest<WeightRecord, Mass> aggregateMax({
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
  DeleteRecordsByIdsRequest<WeightRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<WeightRecord> deleteInTimeRange({
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
