part of '../health_data_type.dart';

/// Paddle sports distance data type.
///
/// Tracks distance traveled using a paddle (rowing, canoeing, etc.).
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distancePaddleSports`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancepaddlesports)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query paddle sports distance records
/// - Writeable: Write paddle sports distance records
/// - Aggregatable: Sum total paddle sports distance
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class PaddleSportsDistanceDataType
    extends DistanceActivityDataType<PaddleSportsDistanceRecord> {
  /// Creates a paddle sports distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PaddleSportsDistanceDataType();

  @override
  String get id => 'paddle_sports_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaddleSportsDistanceDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<PaddleSportsDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PaddleSportsDistanceRecord> readInTimeRange({
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
  AggregateRequest<PaddleSportsDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<PaddleSportsDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<PaddleSportsDistanceRecord>
  deleteInTimeRange({
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
