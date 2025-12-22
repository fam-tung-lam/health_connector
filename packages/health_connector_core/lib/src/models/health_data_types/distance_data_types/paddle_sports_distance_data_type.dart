part of '../health_data_type.dart';

/// Health data type for paddle sports distance.
///
/// Includes kayaking, canoeing, stand-up paddleboarding, etc.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.distancePaddleSports`
///
/// ## iOS Version Requirement
/// **Requires iOS 18.0+**
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class PaddleSportsDistanceDataType
    extends DistanceActivityHealthDataType<PaddleSportsDistanceRecord> {
  @internal
  const PaddleSportsDistanceDataType();

  @override
  String get identifier => 'paddleSportsDistance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaddleSportsDistanceDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  ReadRecordByIdRequest<PaddleSportsDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PaddleSportsDistanceRecord> readInTimeRange({
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
  AggregateRequest<PaddleSportsDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<PaddleSportsDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<PaddleSportsDistanceRecord>
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
