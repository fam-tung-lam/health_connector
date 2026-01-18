part of '../health_data_type.dart';

/// Stair ascent speed data type.
///
/// Tracks vertical speed while climbing stairs.
///
/// ## Measurement Unit
///
/// Values are measured in [Velocity] units (meters/second typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.stairAscentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed)
/// - **Android Health Connect**: Not directly supported (use general
/// [SpeedSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query stair ascent speed records
/// - Writeable: Write stair ascent speed records
/// - Aggregatable: Calculate average stair ascent speed
/// - Deletable: Delete records by IDs or time range
///
/// Represents the speed at which a user ascends stairs, typically measured in
/// meters per second.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.stairAscentSpeed`
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class StairAscentSpeedDataType
    extends SpeedActivityDataType<StairAscentSpeedRecord> {
  /// Creates a stair ascent speed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const StairAscentSpeedDataType();

  @override
  String get id => 'stair_ascent_speed';

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
    return StandardAggregateRequest(
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
