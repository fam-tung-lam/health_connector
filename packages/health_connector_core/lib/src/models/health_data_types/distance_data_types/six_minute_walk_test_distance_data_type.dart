part of '../health_data_type.dart';

/// Health data type for six-minute walk test distance.
///
/// A standardized medical assessment measuring the distance walked in
/// six minutes, commonly used to evaluate functional exercise capacity.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.sixMinuteWalkTestDistance`
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class SixMinuteWalkTestDistanceDataType
    extends DistanceActivityHealthDataType<SixMinuteWalkTestDistanceRecord> {
  @internal
  const SixMinuteWalkTestDistanceDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SixMinuteWalkTestDistanceDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<SixMinuteWalkTestDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SixMinuteWalkTestDistanceRecord>
  readInTimeRange({
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
  AggregateRequest<SixMinuteWalkTestDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<SixMinuteWalkTestDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<SixMinuteWalkTestDistanceRecord>
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
