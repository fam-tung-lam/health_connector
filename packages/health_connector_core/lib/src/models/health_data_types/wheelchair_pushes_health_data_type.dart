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
/// - **Android (Health Connect)**: `WheelchairPushesRecord`
/// - **iOS (HealthKit)**: `HKQuantityType(.pushCount)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query wheelchair pushes records
/// - ✅ Writeable: Write wheelchair pushes records
/// - ✅ Aggregatable: Sum total wheelchair pushes
@sinceV1_0_0
@immutable
final class WheelchairPushesHealthDataType
    extends HealthDataType<WheelchairPushesRecord, Number>
    implements
        ReadableHealthDataType<WheelchairPushesRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<WheelchairPushesRecord, Number> {
  /// Creates a wheelchair pushes data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WheelchairPushesHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelchairPushesHealthDataType &&
          runtimeType == other.runtimeType;

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
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<WheelchairPushesRecord, Number> aggregateSum({
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
  List<Permission> get permissions => [readPermission, writePermission];
}
