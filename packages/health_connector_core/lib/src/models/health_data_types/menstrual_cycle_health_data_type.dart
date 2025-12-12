part of 'health_data_type.dart';

/// Menstrual cycle health data type (iOS only).
///
/// Represents menstrual flow data on iOS.
/// Includes flow intensity and cycle start metadata.
@sinceV1_4_0
@supportedOnAppleHealth
@immutable
final class MenstrualCycleHealthDataType
    extends HealthDataType<MenstrualCycleRecord, MeasurementUnit>
    implements ReadableHealthDataType, WriteableHealthDataType {
  const MenstrualCycleHealthDataType();

  @override
  String get identifier => 'menstrual_cycle';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get name => identifier;

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
  ReadRecordRequest<MenstrualCycleRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<MenstrualCycleRecord> readRecords({
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
