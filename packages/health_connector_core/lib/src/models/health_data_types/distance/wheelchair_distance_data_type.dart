part of '../health_data_type.dart';

/// Wheelchair distance data type.
///
/// Tracks distance traveled while using a wheelchair.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceWheelchair`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query wheelchair distance records
/// - Writeable: Write wheelchair distance records
/// - Aggregatable: Sum total wheelchair distance
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WheelchairDistanceDataType
    extends DistanceActivityDataType<WheelchairDistanceRecord> {
  /// Creates a wheelchair distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WheelchairDistanceDataType();

  @override
  String get id => 'wheelchair_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelchairDistanceDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<WheelchairDistanceRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WheelchairDistanceRecord> readInTimeRange({
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
  AggregateRequest<WheelchairDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<WheelchairDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<WheelchairDistanceRecord> deleteInTimeRange({
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
