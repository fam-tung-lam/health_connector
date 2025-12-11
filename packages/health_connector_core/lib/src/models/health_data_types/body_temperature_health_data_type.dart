part of 'health_data_type.dart';

/// Health data type for body temperature information.
@sinceV1_0_0
@immutable
final class BodyTemperatureHealthDataType
    extends HealthDataType<BodyTemperatureRecord, Temperature>
    implements
        ReadableHealthDataType<BodyTemperatureRecord>,
        WriteableHealthDataType {
  @internal
  const BodyTemperatureHealthDataType();

  @override
  String get identifier => 'bodyTemperature';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'body_temperature_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<BodyTemperatureRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<BodyTemperatureRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
