part of 'health_data_type.dart';

/// Forced expiratory volume data type.
///
/// Forced Expiratory Volume 1 (FEV1) is the amount of air that can be
/// forcibly exhaled from the lungs in the first second of a forced exhalation.
///
/// ## Measurement Unit
///
/// Values are measured in [Volume] units.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.forcedExpiratoryVolume1`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedexpiratoryvolume1)
///
/// ## Capabilities
///
/// - Readable: Query forced expiratory volume records
/// - Writeable: Write forced expiratory volume records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete forced expiratory volume records by IDs or time range
///
/// ## See also
///
/// - [ForcedExpiratoryVolumeRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@immutable
final class ForcedExpiratoryVolumeDataType
    extends HealthDataType<ForcedExpiratoryVolumeRecord, Volume>
    implements
        ReadableHealthDataType<ForcedExpiratoryVolumeRecord>,
        ReadableByIdHealthDataType<ForcedExpiratoryVolumeRecord>,
        ReadableInTimeRangeHealthDataType<ForcedExpiratoryVolumeRecord>,
        WriteableHealthDataType<ForcedExpiratoryVolumeRecord>,
        DeletableByIdsHealthDataType<ForcedExpiratoryVolumeRecord>,
        DeletableInTimeRangeHealthDataType<ForcedExpiratoryVolumeRecord>,
        AvgAggregatableHealthDataType<Volume>,
        MinAggregatableHealthDataType<Volume>,
        MaxAggregatableHealthDataType<Volume> {
  /// Creates a forced expiratory volume data type.
  const ForcedExpiratoryVolumeDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'forced_expiratory_volume';

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
  ReadRecordByIdRequest<ForcedExpiratoryVolumeRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ForcedExpiratoryVolumeRecord> readInTimeRange({
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
