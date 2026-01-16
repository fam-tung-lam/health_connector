part of 'health_data_type.dart';

/// Blood alcohol content data type.
///
/// Tracks the user's blood alcohol content (BAC), typically expressed as a
/// percentage.
///
/// ## Measurement Unit
///
/// Values are measured as [Percentage].
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodAlcoholContent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodAlcoholContent)
/// - **Android Health Connect**: Not supported.
///
/// ## Capabilities
///
/// - Readable: Query BAC records
/// - Writeable: Write BAC records
/// - Aggregatable: Avg, Min, Max
/// - Deletable: Delete BAC records by IDs or time range
///
/// ## See also
///
/// - [BloodAlcoholContentRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class BloodAlcoholContentDataType
    extends HealthDataType<BloodAlcoholContentRecord, Percentage>
    implements
        ReadableHealthDataType<BloodAlcoholContentRecord>,
        WriteableHealthDataType<BloodAlcoholContentRecord>,
        AvgAggregatableHealthDataType<BloodAlcoholContentRecord, Percentage>,
        MinAggregatableHealthDataType<BloodAlcoholContentRecord, Percentage>,
        MaxAggregatableHealthDataType<BloodAlcoholContentRecord, Percentage>,
        DeletableHealthDataType<BloodAlcoholContentRecord> {
  /// Creates a blood alcohol content data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BloodAlcoholContentDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'blood_alcohol_content';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodAlcoholContentDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<BloodAlcoholContentRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BloodAlcoholContentRecord> readInTimeRange({
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
  AggregateRequest<BloodAlcoholContentRecord, Percentage> aggregateAvg({
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
  AggregateRequest<BloodAlcoholContentRecord, Percentage> aggregateMin({
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
  AggregateRequest<BloodAlcoholContentRecord, Percentage> aggregateMax({
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
  DeleteRecordsByIdsRequest<BloodAlcoholContentRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BloodAlcoholContentRecord> deleteInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;
}
