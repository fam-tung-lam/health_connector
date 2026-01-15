part of '../health_data_type.dart';

/// Elevation gained data type.
///
/// Represents the elevation gained by the user.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ElevationGainedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ElevationGainedRecord)
/// - **iOS HealthKit**: Not supported.
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnHealthConnect
@immutable
final class ElevationGainedDataType
    extends HealthDataType<ElevationGainedRecord, Length>
    implements
        ReadableHealthDataType<ElevationGainedRecord>,
        WriteableHealthDataType<ElevationGainedRecord>,
        SumAggregatableHealthDataType<ElevationGainedRecord, Length> {
  /// Creates an elevation gained data type.
  @internal
  const ElevationGainedDataType();

  @override
  String get id => 'elevation_gained';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElevationGainedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ElevationGainedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ElevationGainedRecord> readInTimeRange({
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<ElevationGainedRecord, Length> aggregateSum({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;
}
