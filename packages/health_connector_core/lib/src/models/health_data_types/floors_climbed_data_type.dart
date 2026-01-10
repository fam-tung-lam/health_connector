part of 'health_data_type.dart';

/// Floors climbed data type.
///
/// Tracks the number of floors (flights of stairs) climbed, typically measured
/// by devices with barometric altimeters. One floor is approximately 10 feet
/// (3 meters) of elevation gain.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (count of floors).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`FloorsClimbedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.flightsClimbed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)
///
/// ## Capabilities
///
/// - Readable: Query floors climbed records
/// - Writeable: Write floors climbed records
/// - Aggregatable: Sum total floors climbed
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [FloorsClimbedRecord]
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class FloorsClimbedDataType
    extends HealthDataType<FloorsClimbedRecord, Number>
    implements
        ReadableHealthDataType<FloorsClimbedRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<FloorsClimbedRecord, Number>,
        DeletableHealthDataType<FloorsClimbedRecord> {
  /// Creates a floors climbed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const FloorsClimbedDataType();

  @override
  String get id => 'floors_climbed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorsClimbedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  ReadRecordByIdRequest<FloorsClimbedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<FloorsClimbedRecord> readInTimeRange({
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
  AggregateRequest<FloorsClimbedRecord, Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  DeleteRecordsByIdsRequest<FloorsClimbedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<FloorsClimbedRecord> deleteInTimeRange({
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
