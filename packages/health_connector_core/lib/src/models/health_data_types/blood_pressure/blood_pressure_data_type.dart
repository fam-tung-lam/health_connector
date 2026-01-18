part of '../health_data_type.dart';

/// Composite blood pressure data type.
///
/// Represents a complete blood pressure reading with both systolic and
/// diastolic values in a single measurement. Blood press records include
/// measurement context (body position, measurement location).
///
/// ## Measurement Unit
///
/// Values are measured in [Pressure] units (mmHg typically).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)
/// - **iOS HealthKit**: [`HKCorrelationTypeIdentifier.bloodPressure`](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/bloodpressure)
///
/// ## Capabilities
///
/// - Readable: Query blood pressure records
/// - Writeable: Write blood pressure records
/// - Aggregatable: Calculate avg, min, max blood pressure
/// - Deletable: Delete records by IDs or time range
///
/// ## Related Types
///
/// For individual component measurements, see:
/// - [SystolicBloodPressureDataType] - Systolic pressure only
/// - [DiastolicBloodPressureDataType] - Diastolic pressure only
///
/// ## See also
///
/// - [BloodPressureRecord]
///
/// {@category Health Records}
@sinceV1_2_0
@immutable
final class BloodPressureDataType
    extends HealthDataType<BloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<BloodPressureRecord>,
        ReadableByIdHealthDataType<BloodPressureRecord>,
        ReadableInTimeRangeHealthDataType<BloodPressureRecord>,
        WriteableHealthDataType<BloodPressureRecord>,
        DeletableByIdsHealthDataType<BloodPressureRecord>,
        DeletableInTimeRangeHealthDataType<BloodPressureRecord> {
  /// Creates a blood pressure data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BloodPressureDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'blood_pressure';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BloodPressureRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BloodPressureRecord> readInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  /// Creates a request to calculate average blood pressure.
  BloodPressureAggregateRequest aggregateAverage({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  /// Creates a request to find minimum blood pressure.
  BloodPressureAggregateRequest aggregateMin({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  /// Creates a request to find maximum blood pressure.
  BloodPressureAggregateRequest aggregateMax({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.max,
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
