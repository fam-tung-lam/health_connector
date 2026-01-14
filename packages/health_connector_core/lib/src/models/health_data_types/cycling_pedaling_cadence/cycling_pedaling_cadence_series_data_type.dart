part of '../health_data_type.dart';

/// Health data type for Android cycling pedaling cadence series records.
///
/// Cycling pedaling cadence series records on Android are container
/// records with embedded RPM samples. Each record has a single ID that
/// encompasses all measurements.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**:
///   [`CyclingPedalingCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord)
/// - **iOS HealthKit**: Not supported (iOS uses discrete
///   [CyclingPedalingCadenceDataType] samples)
///
/// ## Capabilities
///
/// - Readable: Query cycling pedaling cadence series
/// - Writeable: Write cycling pedaling cadence series
/// - Aggregatable: Calculate avg, min, max cadence
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [CyclingPedalingCadenceSeriesRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class CyclingPedalingCadenceSeriesDataType
    extends HealthDataType<CyclingPedalingCadenceSeriesRecord, Number>
    implements
        ReadableHealthDataType<CyclingPedalingCadenceSeriesRecord>,
        WriteableHealthDataType<CyclingPedalingCadenceSeriesRecord>,
        AvgAggregatableHealthDataType<
          CyclingPedalingCadenceSeriesRecord,
          Number
        >,
        MinAggregatableHealthDataType<
          CyclingPedalingCadenceSeriesRecord,
          Number
        >,
        MaxAggregatableHealthDataType<
          CyclingPedalingCadenceSeriesRecord,
          Number
        >,
        DeletableHealthDataType<CyclingPedalingCadenceSeriesRecord> {
  /// Creates a cycling pedaling cadence series data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingPedalingCadenceSeriesDataType();

  @override
  String get id => 'cycling_pedaling_cadence_series';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceSeriesDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CyclingPedalingCadenceSeriesRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CyclingPedalingCadenceSeriesRecord>
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
  AggregateRequest<CyclingPedalingCadenceSeriesRecord, Number> aggregateAvg({
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
  AggregateRequest<CyclingPedalingCadenceSeriesRecord, Number> aggregateMin({
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
  AggregateRequest<CyclingPedalingCadenceSeriesRecord, Number> aggregateMax({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  DeleteRecordsByIdsRequest<CyclingPedalingCadenceSeriesRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<CyclingPedalingCadenceSeriesRecord>
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
