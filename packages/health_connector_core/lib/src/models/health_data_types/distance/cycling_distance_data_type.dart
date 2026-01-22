part of '../health_data_type.dart';

/// Cycling distance data type.
///
/// Tracks distance traveled while cycling, measured during cycling activities.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceCycling`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query cycling distance records
/// - Writeable: Write cycling distance records
/// - Aggregatable: Sum total cycling distance
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CyclingDistanceDataType
    extends DistanceActivityDataType<CyclingDistanceRecord>
    implements
        ReadableByIdHealthDataType<CyclingDistanceRecord>,
        ReadableInTimeRangeHealthDataType<CyclingDistanceRecord> {
  /// Creates a cycling distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingDistanceDataType();

  @override
  String get id => 'cycling_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingDistanceDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<CyclingDistanceRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CyclingDistanceRecord> readInTimeRange({
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
  AggregateRequest<Length> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
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
