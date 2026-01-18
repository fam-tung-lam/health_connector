part of '../health_data_type.dart';

/// Rowing distance data type.
///
/// Tracks distance traveled while rowing.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceRowing`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancerowing)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query rowing distance records
/// - Writeable: Write rowing distance records
/// - Aggregatable: Sum total rowing distance
/// - Deletable: Delete records by IDs or time range
///
/// Includes both water rowing and rowing machine exercises.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceRowing`
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class RowingDistanceDataType
    extends DistanceActivityDataType<RowingDistanceRecord>
    implements
        ReadableByIdHealthDataType<RowingDistanceRecord>,
        ReadableInTimeRangeHealthDataType<RowingDistanceRecord> {
  /// Creates a rowing distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const RowingDistanceDataType();

  @override
  String get id => 'rowing_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RowingDistanceDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<RowingDistanceRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RowingDistanceRecord> readInTimeRange({
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
