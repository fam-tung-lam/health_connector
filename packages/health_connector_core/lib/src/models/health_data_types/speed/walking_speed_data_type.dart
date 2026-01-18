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
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.walkingSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed)
/// - **Android Health Connect**: Not directly supported (use general
/// [SpeedSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query walking speed records
/// - Writeable: Write walking speed records
/// - Aggregatable: Calculate average walking speed
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WalkingSpeedDataType
    extends SpeedActivityDataType<WalkingSpeedRecord> {
  /// Creates a walking speed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingSpeedDataType();

  @override
  String get id => 'walking_speed';

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
  AggregateRequest<Velocity> aggregateAvg({
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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
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
