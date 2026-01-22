part of '../health_data_type.dart';

/// Stair descent speed data type.
///
/// Tracks vertical speed while descending stairs.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.stairDescentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed)
/// - **Android Health Connect**: Not directly supported (use general
/// [SpeedSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query stair descent speed records
/// - Writeable: Write stair descent speed records
/// - Aggregatable: Calculate average stair descent speed
/// - Deletable: Delete records by IDs or time range
///
/// Represents the speed at which a user descends stairs, typically measured in
/// meters per second.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.stairDescentSpeed`
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class StairDescentSpeedDataType
    extends SpeedActivityDataType<StairDescentSpeedRecord> {
  /// Creates a stair descent speed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const StairDescentSpeedDataType();

  @override
  String get id => 'stair_descent_speed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StairDescentSpeedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<StairDescentSpeedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<StairDescentSpeedRecord> readInTimeRange({
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
