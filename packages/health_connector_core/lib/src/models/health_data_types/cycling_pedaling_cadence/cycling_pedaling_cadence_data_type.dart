part of '../health_data_type.dart';

/// Cycling pedaling cadence measurement data type.
///
/// Represents individual cycling pedaling cadence measurements in
/// revolutions per minute (RPM).
/// Each measurement is a discrete reading typically taken at a specific point
/// in time during cycling activity.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (revolutions per minute).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**:
///   [`HKQuantityTypeIdentifier.cyclingCadence`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingcadence)
/// - **Android Health Connect**: Use
///   [CyclingPedalingCadenceSeriesDataType] instead
///
/// ## Capabilities
///
/// - Readable: Query cycling pedaling cadence measurements
/// - Writeable: Write cycling pedaling cadence measurements
/// - Aggregatable: Calculate avg, min, max cadence
/// - Deletable: Delete records by IDs or time range
///
/// ## Platform Notes
///
/// On iOS, cycling pedaling cadence data is stored as individual
/// measurement samples. Each record has its own UUID and can be queried
/// independently.
///
/// ## See also
///
/// - [CyclingPedalingCadenceRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@immutable
final class CyclingPedalingCadenceDataType
    extends HealthDataType<CyclingPedalingCadenceRecord, Number>
    implements
        ReadableHealthDataType<CyclingPedalingCadenceRecord>,
        ReadableByIdHealthDataType<CyclingPedalingCadenceRecord>,
        ReadableInTimeRangeHealthDataType<CyclingPedalingCadenceRecord>,
        WriteableHealthDataType<CyclingPedalingCadenceRecord>,
        AvgAggregatableHealthDataType<Number>,
        MinAggregatableHealthDataType<Number>,
        MaxAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<CyclingPedalingCadenceRecord>,
        DeletableInTimeRangeHealthDataType<CyclingPedalingCadenceRecord> {
  /// Creates a cycling pedaling cadence measurement data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingPedalingCadenceDataType();

  @override
  String get id => 'cycling_pedaling_cadence';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceDataType &&
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
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CyclingPedalingCadenceRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CyclingPedalingCadenceRecord> readInTimeRange({
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
  AggregateRequest<Number> aggregateAvg({
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
  AggregateRequest<Number> aggregateMin({
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
  AggregateRequest<Number> aggregateMax({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

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
