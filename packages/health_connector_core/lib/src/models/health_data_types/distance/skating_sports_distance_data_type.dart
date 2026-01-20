part of '../health_data_type.dart';

/// Skating sports distance data type.
///
/// Tracks distance traveled while ice skating or roller skating.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceSkatingSports`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceskatingsports)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query skating sports distance records
/// - Writeable: Write skating sports distance records
/// - Aggregatable: Sum total skating sports distance
/// - Deletable: Delete records by IDs or time range
///
/// Includes ice skating, roller skating, inline skating, etc.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceSkatingSports`
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealthIOS18Plus
@immutable
final class SkatingSportsDistanceDataType
    extends DistanceActivityDataType<SkatingSportsDistanceRecord>
    implements
        ReadableByIdHealthDataType<SkatingSportsDistanceRecord>,
        ReadableInTimeRangeHealthDataType<SkatingSportsDistanceRecord> {
  /// Creates a skating sports distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SkatingSportsDistanceDataType();

  @override
  String get id => 'skating_sports_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkatingSportsDistanceDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<SkatingSportsDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SkatingSportsDistanceRecord> readInTimeRange({
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
