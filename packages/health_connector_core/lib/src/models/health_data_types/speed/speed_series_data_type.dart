part of '../health_data_type.dart';

/// Health data type for speed information.
///
/// This data type is for Android Health Connect only. It represents generic
/// speed measurements captured as a series of samples over a time interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `SpeedRecord`
/// - **iOS HealthKit**: Not supported (Use specific speed data types)
///
/// ## iOS Alternative
/// For iOS, use the activity-specific speed types:
/// - [WalkingSpeedDataType]
/// - [RunningSpeedDataType]
/// - [StairAscentSpeedDataType]
/// - [StairDescentSpeedDataType]
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnHealthConnect
@immutable
final class SpeedSeriesDataType
    extends HealthDataType<SpeedSeriesRecord, Velocity>
    implements
        ReadableHealthDataType<SpeedSeriesRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType,
        AvgAggregatableHealthDataType<SpeedSeriesRecord, Velocity>,
        MinAggregatableHealthDataType<SpeedSeriesRecord, Velocity>,
        MaxAggregatableHealthDataType<SpeedSeriesRecord, Velocity> {
  /// Creates a speed series data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SpeedSeriesDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedSeriesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  ReadRecordByIdRequest<SpeedSeriesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SpeedSeriesRecord> readInTimeRange({
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
  AggregateRequest<SpeedSeriesRecord, Velocity> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<SpeedSeriesRecord, Velocity> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<SpeedSeriesRecord, Velocity> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  DeleteRecordsByIdsRequest<SpeedSeriesRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<SpeedSeriesRecord> deleteInTimeRange({
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
