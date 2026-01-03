part of '../health_data_type.dart';

/// Cycling distance data type.
///
/// Tracks distance traveled while cycling, measured during cycling activities.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters, kilometers, miles, etc.).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceCycling`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceHealthDataType])
///
/// ## Capabilities
///
/// - Readable: Query cycling distance records
/// - Writeable: Write cycling distance records
/// - Aggregatable: Sum total cycling distance
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CyclingDistanceDataType
    extends DistanceActivityHealthDataType<CyclingDistanceRecord> {
  /// Creates a cycling distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingDistanceDataType();

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
  AggregateRequest<CyclingDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<CyclingDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<CyclingDistanceRecord> deleteInTimeRange({
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
