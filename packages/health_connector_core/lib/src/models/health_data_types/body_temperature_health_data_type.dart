part of 'health_data_type.dart';

/// Body temperature data type.
///
/// Represents body temperature measurements, typically used for monitoring
/// health status, fever detection, and reproductive health tracking.
///
/// ## Measurement Unit
///
/// Values are measured in [Temperature] units (Celsius, Fahrenheit, Kelvin).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `BodyTemperatureRecord`
/// - **iOS HealthKit**: `HKQuantityType(.bodyTemperature)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query body temperature records
/// - ✅ Writeable: Write body temperature records
/// - ✅ Deletable: Delete records by IDs or time range
/// - ❌ Not aggregatable
@sinceV1_0_0
@immutable
final class BodyTemperatureHealthDataType
    extends HealthDataType<BodyTemperatureRecord, Temperature>
    implements
        ReadableHealthDataType<BodyTemperatureRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<BodyTemperatureRecord> {
  /// Creates a body temperature data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BodyTemperatureHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BodyTemperatureRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyTemperatureRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  DeleteRecordsByIdsRequest<BodyTemperatureRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BodyTemperatureRecord> deleteInTimeRange({
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
