part of '../health_data_type.dart';

/// Walking and running distance data type.
///
/// Tracks combined distance from walking and running activities, the most
/// common forms of daily movement and exercise.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters, kilometers, miles, etc.).
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit) Only**: `HKQuantityType(.distanceWalkingRunning)`
/// - **Android (Health Connect)**: Not directly supported (use general distance
/// records)
///
/// ## Capabilities
///
/// - ✅ Readable: Query walking/running distance records
/// - ✅ Writeable: Write walking/running distance records
/// - ✅ Aggregatable: Sum total walking/running distance
/// - ✅ Deletable: Delete records by IDs or time range
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingRunningDistanceDataType
    extends DistanceActivityHealthDataType<WalkingRunningDistanceRecord> {
  /// Creates a walking/running distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingRunningDistanceDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingRunningDistanceDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<WalkingRunningDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingRunningDistanceRecord> readInTimeRange({
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
  AggregateRequest<WalkingRunningDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<WalkingRunningDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<WalkingRunningDistanceRecord>
  deleteInTimeRange({
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
