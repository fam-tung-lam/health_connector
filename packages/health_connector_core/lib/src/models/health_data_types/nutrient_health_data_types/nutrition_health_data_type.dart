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
  ReadRecordByIdRequest<NutritionRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<NutritionRecord> readInTimeRange({
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
}
