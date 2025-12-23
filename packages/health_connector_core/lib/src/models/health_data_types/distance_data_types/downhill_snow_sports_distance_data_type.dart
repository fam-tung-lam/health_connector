part of '../health_data_type.dart';

/// Downhill snow sports distance data type.
///
/// Tracks distance traveled while skiing or snowboarding downhill.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.distanceDownhillSnowSports)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query downhill snow sports distance records
/// - ✅ Writeable: Write downhill snow sports distance records
/// - ✅ Aggregatable: Sum total downhill snow sports distance
/// - ✅ Deletable: Delete records by IDs or time range
///
/// Includes skiing, snowboarding, and other downhill winter sports.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceDownhillSnowSports`
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class DownhillSnowSportsDistanceDataType
    extends DistanceActivityHealthDataType<DownhillSnowSportsDistanceRecord> {
  /// Creates a downhill snow sports distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DownhillSnowSportsDistanceDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownhillSnowSportsDistanceDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<DownhillSnowSportsDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DownhillSnowSportsDistanceRecord>
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
  AggregateRequest<DownhillSnowSportsDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<DownhillSnowSportsDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<DownhillSnowSportsDistanceRecord>
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
