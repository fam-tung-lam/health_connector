part of 'health_data_type.dart';

/// Menstruation period health data type (Android only).
///
/// Represents a complete menstrual period. On Android, this type
/// aggregates [MenstruationPeriodRecord] (interval) and its associated
/// [MenstruationFlowRecord]s (instant samples).
@sinceV1_4_0
@supportedOnHealthConnect
@immutable
final class MenstruationPeriodHealthDataType
    extends HealthDataType<MenstruationPeriodRecord, MeasurementUnit>
    implements ReadableHealthDataType, WriteableHealthDataType {
  const MenstruationPeriodHealthDataType();

  @override
  String get identifier => 'menstruation_period';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  ReadRecordRequest<MenstruationPeriodRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<MenstruationPeriodRecord> readRecords({
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
}
