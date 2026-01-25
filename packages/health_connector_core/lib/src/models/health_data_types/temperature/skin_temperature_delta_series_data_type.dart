part of '../health_data_type.dart';

/// Represents the Skin Temperature health data type.
///
/// This data type captures the skin temperature of a user. Each record can
/// represent a series of measurements of temperature differences.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SkinTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SkinTemperatureRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query skin temperature delta series records
/// - Writeable: Write skin temperature delta series records
/// - Aggregatable: Calculate avg, min, max temperature delta
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [SkinTemperatureDeltaSeriesRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class SkinTemperatureDeltaSeriesDataType
    extends HealthDataType<SkinTemperatureDeltaSeriesRecord, Temperature>
    implements
        ReadableByIdHealthDataType<SkinTemperatureDeltaSeriesRecord>,
        ReadableInTimeRangeHealthDataType<SkinTemperatureDeltaSeriesRecord>,
        WriteableHealthDataType<SkinTemperatureDeltaSeriesRecord>,
        AvgAggregatableHealthDataType<Temperature>,
        MinAggregatableHealthDataType<Temperature>,
        MaxAggregatableHealthDataType<Temperature>,
        DeletableByIdsHealthDataType<SkinTemperatureDeltaSeriesRecord>,
        DeletableInTimeRangeHealthDataType<SkinTemperatureDeltaSeriesRecord> {
  /// Creates a skin temperature data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SkinTemperatureDeltaSeriesDataType();

  @override
  String get id => 'skin_temperature';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkinTemperatureDeltaSeriesDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SkinTemperatureDeltaSeriesRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SkinTemperatureDeltaSeriesRecord>
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<Temperature> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Temperature> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Temperature> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
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
