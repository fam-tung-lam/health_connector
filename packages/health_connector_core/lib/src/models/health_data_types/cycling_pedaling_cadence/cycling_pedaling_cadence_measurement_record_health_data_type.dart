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
///   [CyclingPedalingCadenceSeriesRecordHealthDataType] instead
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
/// - [CyclingPedalingCadenceMeasurementRecord]
///
/// {@category Health Data Types}
@sinceV2_2_0
@immutable
final class CyclingPedalingCadenceMeasurementRecordHealthDataType
    extends HealthDataType<CyclingPedalingCadenceMeasurementRecord, Number>
    implements
        ReadableHealthDataType<CyclingPedalingCadenceMeasurementRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<
          CyclingPedalingCadenceMeasurementRecord,
          Number
        >,
        MinAggregatableHealthDataType<
          CyclingPedalingCadenceMeasurementRecord,
          Number
        >,
        MaxAggregatableHealthDataType<
          CyclingPedalingCadenceMeasurementRecord,
          Number
        >,
        DeletableHealthDataType<CyclingPedalingCadenceMeasurementRecord> {
  /// Creates a cycling pedaling cadence measurement data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingPedalingCadenceMeasurementRecordHealthDataType();

  @override
  String get id => 'cycling_pedaling_cadence_measurement_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceMeasurementRecordHealthDataType &&
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
  ReadRecordByIdRequest<CyclingPedalingCadenceMeasurementRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CyclingPedalingCadenceMeasurementRecord>
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
  AggregateRequest<CyclingPedalingCadenceMeasurementRecord, Number>
  aggregateAvg({
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
  AggregateRequest<CyclingPedalingCadenceMeasurementRecord, Number>
  aggregateMin({
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
  AggregateRequest<CyclingPedalingCadenceMeasurementRecord, Number>
  aggregateMax({
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
  DeleteRecordsByIdsRequest<CyclingPedalingCadenceMeasurementRecord>
  deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<CyclingPedalingCadenceMeasurementRecord>
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
