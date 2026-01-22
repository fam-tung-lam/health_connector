part of 'health_data_type.dart';

/// Electrodermal activity data type.
///
/// Tracks skin conductance, which increases as sweat gland activity increases.
/// Commonly used in stress monitoring and biofeedback applications.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.electrodermalActivity`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/electrodermalactivity)
///
/// ## Capabilities
///
/// - Readable: Query electrodermal activity records
/// - Writeable: Write electrodermal activity records
/// - Aggregatable: Min, max, and average conductance
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [ElectrodermalActivityRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class ElectrodermalActivityDataType
    extends HealthDataType<ElectrodermalActivityRecord, Number>
    implements
        ReadableByIdHealthDataType<ElectrodermalActivityRecord>,
        ReadableInTimeRangeHealthDataType<ElectrodermalActivityRecord>,
        WriteableHealthDataType<ElectrodermalActivityRecord>,
        MinAggregatableHealthDataType<Number>,
        MaxAggregatableHealthDataType<Number>,
        AvgAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<ElectrodermalActivityRecord>,
        DeletableInTimeRangeHealthDataType<ElectrodermalActivityRecord> {
  /// Creates an electrodermal activity data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ElectrodermalActivityDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'electrodermal_activity';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrodermalActivityDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ElectrodermalActivityRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ElectrodermalActivityRecord> readInTimeRange({
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

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;
}
