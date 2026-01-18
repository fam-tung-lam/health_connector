part of 'health_data_type.dart';

/// Wheelchair pushes data type.
///
/// Tracks the number of wheelchair pushes, used for monitoring mobility
/// and activity for wheelchair users.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (count of pushes).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `WheelchairPushesRecord`
/// - **iOS HealthKit**: `HKQuantityType(.pushCount)`
///
/// ## Capabilities
///
/// - Readable: Query wheelchair pushes records
/// - Writeable: Write wheelchair pushes records
/// - Aggregatable: Sum total wheelchair pushes
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [WheelchairPushesRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class WheelchairPushesDataType
    extends HealthDataType<WheelchairPushesRecord, Number>
    implements
        ReadableByIdHealthDataType<WheelchairPushesRecord>,
        ReadableInTimeRangeHealthDataType<WheelchairPushesRecord>,
        WriteableHealthDataType<WheelchairPushesRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<WheelchairPushesRecord>,
        DeletableInTimeRangeHealthDataType<WheelchairPushesRecord> {
  /// Creates a wheelchair pushes data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WheelchairPushesDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'wheelchair_pushes';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelchairPushesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WheelchairPushesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WheelchairPushesRecord> readInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

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
}
