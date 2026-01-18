part of 'health_data_type.dart';

/// Step count data type.
///
/// Tracks the number of steps taken, typically measured by pedometers,
/// fitness trackers, and smartphones. One of the most commonly tracked
/// health metrics for daily activity monitoring.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (count of steps).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`StepsRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.stepCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)
///
/// ## Capabilities
///
/// - Readable: Query step count records
/// - Writeable: Write step count records
/// - Aggregatable: Sum total steps
/// - Deletable: Delete step records by IDs or time range
///
/// ## See also
///
/// - [StepsRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class StepsDataType extends HealthDataType<StepsRecord, Number>
    implements
        ReadableByIdHealthDataType<StepsRecord>,
        ReadableInTimeRangeHealthDataType<StepsRecord>,
        WriteableHealthDataType<StepsRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<StepsRecord>,
        DeletableInTimeRangeHealthDataType<StepsRecord> {
  /// Creates a steps data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const StepsDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'steps';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<StepsRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<StepsRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;
}
