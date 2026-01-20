part of '../health_data_type.dart';

/// Systolic blood pressure data type.
///
/// Represents the systolic (upper) blood pressure value, measured during
/// the contraction phase of the heart cycle. This is an iOS-specific data type.
///
/// ## Measurement Unit
///
/// Values are measured in [Pressure] units (mmHg, kPa, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Part of [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodPressureSystolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressuresystolic)
///
/// ## Capabilities
///
/// - Readable: Query systolic blood pressure records
/// - Writeable: Write systolic blood pressure records
/// - Aggregatable: Calculate avg, min, max systolic pressure
/// - Deletable: Delete records by IDs or time range
///
/// [!NOTE]
/// This data type is only supported on iOS/HealthKit. For Android,
/// use [BloodPressureDataType] which includes both systolic and
/// diastolic values.
///
/// ## See also
///
/// - [SystolicBloodPressureRecord]
///
/// {@category Health Records}
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class SystolicBloodPressureDataType
    extends HealthDataType<SystolicBloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<SystolicBloodPressureRecord>,
        ReadableByIdHealthDataType<SystolicBloodPressureRecord>,
        ReadableInTimeRangeHealthDataType<SystolicBloodPressureRecord>,
        WriteableHealthDataType<SystolicBloodPressureRecord>,
        AvgAggregatableHealthDataType<Pressure>,
        MinAggregatableHealthDataType<Pressure>,
        MaxAggregatableHealthDataType<Pressure>,
        DeletableByIdsHealthDataType<SystolicBloodPressureRecord>,
        DeletableInTimeRangeHealthDataType<SystolicBloodPressureRecord> {
  /// Creates a systolic blood pressure data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SystolicBloodPressureDataType();

  @override
  String get id => 'systolic_blood_pressure';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystolicBloodPressureDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
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
  ReadRecordByIdRequest<SystolicBloodPressureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SystolicBloodPressureRecord> readInTimeRange({
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
  AggregateRequest<Pressure> aggregateAvg({
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
  AggregateRequest<Pressure> aggregateMin({
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
  AggregateRequest<Pressure> aggregateMax({
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
