part of 'health_data_type.dart';

/// Number of times fallen data type.
///
/// Tracks the number of times the user has fallen.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.numberOfTimesFallen`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/numberoftimesfallen)
///
/// ## Capabilities
///
/// - Readable: Query records
/// - Writeable: Write records
/// - Aggregatable: Sum total counts
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [NumberOfTimesFallenRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class NumberOfTimesFallenDataType
    extends HealthDataType<NumberOfTimesFallenRecord, Number>
    implements
        ReadableByIdHealthDataType<NumberOfTimesFallenRecord>,
        ReadableInTimeRangeHealthDataType<NumberOfTimesFallenRecord>,
        WriteableHealthDataType<NumberOfTimesFallenRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<NumberOfTimesFallenRecord>,
        DeletableInTimeRangeHealthDataType<NumberOfTimesFallenRecord> {
  /// Creates a number of times fallen data type.
  @internal
  const NumberOfTimesFallenDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'number_of_times_fallen';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberOfTimesFallenDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<NumberOfTimesFallenRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<NumberOfTimesFallenRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.mobility;
}
