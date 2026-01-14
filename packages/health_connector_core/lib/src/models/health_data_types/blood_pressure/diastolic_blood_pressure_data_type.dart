part of '../health_data_type.dart';

/// Diastolic blood pressure data type.
///
/// Represents the diastolic (lower) blood pressure value, measured during
/// the relaxation phase of the heart cycle. This is an iOS-specific data type.
///
/// ## Measurement Unit
///
/// Values are measured in [Pressure] units (mmHg, kPa, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Part of [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodPressureDiastolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressurediastolic)
///
/// ## Capabilities
///
/// - Readable: Query diastolic blood pressure records
/// - Writeable: Write diastolic blood pressure records
/// - Aggregatable: Calculate avg, min, max diastolic pressure
/// - Deletable: Delete records by IDs or time range
///
/// > [!NOTE]
/// > This data type is only supported on iOS/HealthKit. For Android,
/// > use [BloodPressureDataType] which includes both systolic and
/// diastolic values.
///
/// ## See also
///
/// - [DiastolicBloodPressureRecord]
///
/// {@category Health Records}
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class DiastolicBloodPressureDataType
    extends HealthDataType<DiastolicBloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<DiastolicBloodPressureRecord>,
        WriteableHealthDataType<DiastolicBloodPressureRecord>,
        AvgAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure>,
        MinAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure>,
        MaxAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure>,
        DeletableHealthDataType<DiastolicBloodPressureRecord> {
  /// Creates a diastolic blood pressure data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DiastolicBloodPressureDataType();

  @override
  String get id => 'diastolic_blood_pressure';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiastolicBloodPressureDataType &&
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
  ReadRecordByIdRequest<DiastolicBloodPressureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DiastolicBloodPressureRecord> readInTimeRange({
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
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateAvg({
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
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateMin({
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
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateMax({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest<DiastolicBloodPressureRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DiastolicBloodPressureRecord>
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
