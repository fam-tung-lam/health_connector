part of '../health_data_type.dart';

@sinceV1_1_0
@immutable
final class NutritionHealthDataType
    extends HealthDataType<NutritionRecord, MeasurementUnit>
    implements
        ReadableHealthDataType<NutritionRecord>,
        WriteableHealthDataType {
  @internal
  const NutritionHealthDataType();

  @override
  String get identifier => 'nutrition';

  @override
  String get name => identifier;

  @override
  List<Permission> get permissions => [readPermission, writePermission];

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
  ReadRecordRequest<NutritionRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<NutritionRecord> readRecords({
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
