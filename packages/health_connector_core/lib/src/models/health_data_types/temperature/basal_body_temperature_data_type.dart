part of '../health_data_type.dart';

/// Basal body temperature data type.
///
/// Represents basal body temperature measurements, which are the lowest body
/// temperature attained during rest. Typically measured immediately after
/// waking and before any physical activity. Commonly used for fertility
/// tracking and menstrual cycle monitoring.
///
/// ## Measurement Unit
///
/// Values are measured in [Temperature] units (Celsius, Fahrenheit, Kelvin).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BasalBodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.basalBodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalbodytemperature)
///
/// ## Capabilities
///
/// - Readable: Query basal body temperature records
/// - Writeable: Write basal body temperature records
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BasalBodyTemperatureRecord]
/// - [BodyTemperatureRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@immutable
final class BasalBodyTemperatureDataType
    extends HealthDataType<BasalBodyTemperatureRecord, Temperature>
    implements
        ReadableByIdHealthDataType<BasalBodyTemperatureRecord>,
        ReadableInTimeRangeHealthDataType<BasalBodyTemperatureRecord>,
        WriteableHealthDataType<BasalBodyTemperatureRecord>,
        DeletableHealthDataType<BasalBodyTemperatureRecord> {
  /// Creates a basal body temperature data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BasalBodyTemperatureDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'basal_body_temperature';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalBodyTemperatureDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BasalBodyTemperatureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BasalBodyTemperatureRecord> readInTimeRange({
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
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

  @override
  DeleteRecordsByIdsRequest<BasalBodyTemperatureRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BasalBodyTemperatureRecord>
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
