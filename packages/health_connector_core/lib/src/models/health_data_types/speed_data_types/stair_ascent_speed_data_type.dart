part of '../health_data_type.dart';

/// Health data type for stair ascent speed.
///
/// Represents the speed at which a user ascends stairs, typically measured in
/// meters per second.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.stairAscentSpeed`
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class StairAscentSpeedDataType
    extends SpeedActivityHealthDataType<StairAscentSpeedRecord> {
  @internal
  const StairAscentSpeedDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StairAscentSpeedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<StairAscentSpeedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<StairAscentSpeedRecord> readInTimeRange({
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
  AggregateRequest<StairAscentSpeedRecord, Velocity> aggregateAvg({
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
  DeleteRecordsByIdsRequest<StairAscentSpeedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<StairAscentSpeedRecord> deleteInTimeRange({
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
