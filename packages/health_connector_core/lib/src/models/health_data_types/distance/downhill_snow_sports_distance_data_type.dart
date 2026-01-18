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
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceDownhillSnowSports`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancedownhillsnowsports)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query downhill snow sports distance records
/// - Writeable: Write downhill snow sports distance records
/// - Aggregatable: Sum total downhill snow sports distance
/// - Deletable: Delete records by IDs or time range
///
/// Includes skiing, snowboarding, and other downhill winter sports.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceDownhillSnowSports`
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class DownhillSnowSportsDistanceDataType
    extends DistanceActivityDataType<DownhillSnowSportsDistanceRecord>
    implements
        ReadableByIdHealthDataType<DownhillSnowSportsDistanceRecord>,
        ReadableInTimeRangeHealthDataType<DownhillSnowSportsDistanceRecord> {
  /// Creates a downhill snow sports distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DownhillSnowSportsDistanceDataType();

  @override
  String get id => 'downhill_snow_sports_distance';

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
