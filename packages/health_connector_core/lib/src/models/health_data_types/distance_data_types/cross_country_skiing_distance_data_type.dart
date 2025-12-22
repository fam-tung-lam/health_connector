part of '../health_data_type.dart';

/// Health data type for cross-country skiing distance.
///
/// Specifically for nordic skiing and cross-country ski touring.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.distanceCrossCountrySkiing`
///
/// ## iOS Version Requirement
/// **Requires iOS 18.0+**
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CrossCountrySkiingDistanceDataType
    extends DistanceActivityHealthDataType<CrossCountrySkiingDistanceRecord> {
  @internal
  const CrossCountrySkiingDistanceDataType();

  @override
  String get identifier => 'crossCountrySkiingDistance';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrossCountrySkiingDistanceDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

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
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
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
