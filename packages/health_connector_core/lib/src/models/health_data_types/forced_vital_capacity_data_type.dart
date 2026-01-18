part of 'health_data_type.dart';

/// Forced vital capacity data type.
///
/// Represents the user's forced vital capacity measurements.
///
/// ## Measurement Unit
///
/// Values are measured in [Volume] units.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.forcedVitalCapacity`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedvitalcapacity)
///
/// ## Capabilities
///
/// - Readable: Query forced vital capacity records
/// - Writeable: Write forced vital capacity records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete forced vital capacity records by IDs or time range
///
/// ## See also
///
/// - [ForcedVitalCapacityRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ForcedVitalCapacityDataType
    extends HealthDataType<ForcedVitalCapacityRecord, Volume>
    implements
        ReadableHealthDataType<ForcedVitalCapacityRecord>,
        ReadableByIdHealthDataType<ForcedVitalCapacityRecord>,
        ReadableInTimeRangeHealthDataType<ForcedVitalCapacityRecord>,
        WriteableHealthDataType<ForcedVitalCapacityRecord>,
        DeletableByIdsHealthDataType<ForcedVitalCapacityRecord>,
        DeletableInTimeRangeHealthDataType<ForcedVitalCapacityRecord>,
        AvgAggregatableHealthDataType<Volume>,
        MinAggregatableHealthDataType<Volume>,
        MaxAggregatableHealthDataType<Volume> {
  /// Creates a forced vital capacity data type.
  const ForcedVitalCapacityDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'forced_vital_capacity';

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
  ReadRecordByIdRequest<ForcedVitalCapacityRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ForcedVitalCapacityRecord> readInTimeRange({
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
    return CommonAggregateRequest(
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
    return CommonAggregateRequest(
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
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
