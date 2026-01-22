part of 'health_data_type.dart';

/// Inhaler usage data type.
///
/// Tracks the number of puffs the user takes from their inhaler over a
/// time interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.inhalerUsage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/inhalerusage)
///
/// ## Capabilities
///
/// - Readable: Query inhaler usage records
/// - Writeable: Write inhaler usage records
/// - Aggregatable: Sum total puffs
/// - Deletable: Delete inhaler usage records by IDs or time range
///
/// ## See also
///
/// - [InhalerUsageRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class InhalerUsageDataType
    extends HealthDataType<InhalerUsageRecord, Number>
    implements
        ReadableByIdHealthDataType<InhalerUsageRecord>,
        ReadableInTimeRangeHealthDataType<InhalerUsageRecord>,
        WriteableHealthDataType<InhalerUsageRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<InhalerUsageRecord>,
        DeletableInTimeRangeHealthDataType<InhalerUsageRecord> {
  /// Creates an inhaler usage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const InhalerUsageDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'inhaler_usage';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InhalerUsageDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<InhalerUsageRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<InhalerUsageRecord> readInTimeRange({
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
  AggregateRequest<Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.clinical;
}
