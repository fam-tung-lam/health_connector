part of 'health_data_type.dart';

/// Blood glucose data type.
///
/// Represents the concentration of glucose in the blood, commonly measured
/// for diabetes management and metabolic health tracking. Blood glucose records
/// include context such as meal relation, specimen source, and measurement
/// type.
///
/// ## Measurement Unit
///
/// Values are measured in [BloodGlucose] units (mg/dL or mmol/L).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BloodGlucoseRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodGlucose`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose)
///
/// ## Capabilities
///
/// - Readable: Query blood glucose records
/// - Writeable: Write blood glucose records
/// - Aggregatable: Calculate avg, min, max blood glucose
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BloodGlucoseRecord]
///
/// {@category Health Records}
@sinceV1_4_0
@immutable
final class BloodGlucoseDataType
    extends HealthDataType<BloodGlucoseRecord, BloodGlucose>
    implements
        ReadableByIdHealthDataType<BloodGlucoseRecord>,
        ReadableInTimeRangeHealthDataType<BloodGlucoseRecord>,
        WriteableHealthDataType<BloodGlucoseRecord>,
        AvgAggregatableHealthDataType<BloodGlucose>,
        MinAggregatableHealthDataType<BloodGlucose>,
        MaxAggregatableHealthDataType<BloodGlucose>,
        DeletableByIdsHealthDataType<BloodGlucoseRecord>,
        DeletableInTimeRangeHealthDataType<BloodGlucoseRecord> {
  /// Creates a blood glucose data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  const BloodGlucoseDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'blood_glucose';

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BloodGlucoseRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BloodGlucoseRecord> readInTimeRange({
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
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  AggregateRequest<BloodGlucose> aggregateAvg({
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
  AggregateRequest<BloodGlucose> aggregateMax({
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
  AggregateRequest<BloodGlucose> aggregateMin({
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
