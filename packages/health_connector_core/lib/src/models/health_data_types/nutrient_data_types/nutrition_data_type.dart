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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

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
