part of '../health_data_type.dart';

/// Running speed data type.
///
/// Tracks the speed at which a user runs, useful for monitoring running
/// performance, pace improvements, and training intensity.
///
/// ## Measurement Unit
///
/// Values are measured in [Velocity] units (meters/second, km/hour, etc.).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.runningSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed)
/// - **Android Health Connect**: Not directly supported (use general
/// [SpeedSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query running speed records
/// - Writeable: Write running speed records
/// - Aggregatable: Calculate average running speed
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class RunningSpeedDataType
    extends SpeedActivityDataType<RunningSpeedRecord> {
  /// Creates a running speed data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const RunningSpeedDataType();

  @override
  String get id => 'running_speed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RunningSpeedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<RunningSpeedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RunningSpeedRecord> readInTimeRange({
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
