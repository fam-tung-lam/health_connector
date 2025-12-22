part of '../health_data_type.dart';

/// Health data type for swimming distance.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.walkingRunning`
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingRunningDistanceDataType
    extends DistanceActivityHealthDataType<WalkingRunningDistanceRecord> {
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
