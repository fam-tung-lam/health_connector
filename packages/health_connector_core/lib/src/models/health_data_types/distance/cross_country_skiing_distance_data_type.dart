part of '../health_data_type.dart';

/// Cross-country skiing distance data type.
///
/// Tracks distance traveled while cross-country skiing.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.distanceCrossCountrySkiing`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecrosscountryskiing)
/// - **Android Health Connect**: Not directly supported (use general
/// [DistanceHealthDataType])
///
/// ## Capabilities
///
/// - Readable: Query cross-country skiing distance records
/// - Writeable: Write cross-country skiing distance records
/// - Aggregatable: Sum total cross-country skiing distance
/// - Deletable: Delete records by IDs or time range
///
/// Specifically for nordic skiing and cross-country ski touring.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceCrossCountrySkiing`
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CrossCountrySkiingDistanceDataType
    extends DistanceActivityHealthDataType<CrossCountrySkiingDistanceRecord> {
  /// Creates a cross-country skiing distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CrossCountrySkiingDistanceDataType();

  @override
  String get id => 'cross_country_skiing_distance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrossCountrySkiingDistanceDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  ReadRecordByIdRequest<CrossCountrySkiingDistanceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CrossCountrySkiingDistanceRecord>
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
  AggregateRequest<CrossCountrySkiingDistanceRecord, Length> aggregateSum({
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
  DeleteRecordsByIdsRequest<CrossCountrySkiingDistanceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<CrossCountrySkiingDistanceRecord>
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
