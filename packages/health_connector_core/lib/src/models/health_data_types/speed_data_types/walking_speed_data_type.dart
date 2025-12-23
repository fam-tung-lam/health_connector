part of '../health_data_type.dart';

/// Walking speed data type.
///
/// Tracks the speed at which a user walks, useful for monitoring mobility,
/// gait speed, and functional fitness.
///
/// ## Measurement Unit
///
/// Values are measured in [Velocity] units (meters/second, km/hour, etc.).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: `HKQuantityType(.walkingSpeed)`
/// - **Android Health Connect**: Not directly supported
///
/// ## Capabilities
///
/// - ✅ Readable: Query walking speed records
/// - ✅ Writeable: Write walking speed records
/// - ✅ Aggregatable: Calculate average walking speed
/// - ✅ Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingSpeedDataType
    extends SpeedActivityHealthDataType<WalkingSpeedRecord> {
  /// Creates a walking speed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingSpeedDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSpeedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<WalkingSpeedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingSpeedRecord> readInTimeRange({
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
  AggregateRequest<WalkingSpeedRecord, Velocity> aggregateAvg({
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
  DeleteRecordsByIdsRequest<WalkingSpeedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<WalkingSpeedRecord> deleteInTimeRange({
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
