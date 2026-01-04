import 'package:health_connector_core/health_connector_core_internal.dart'
    show WaistCircumferenceRecord, HealthRecordId, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show WaistCircumferenceRecordDto, LengthDto, LengthUnitDto; // Added these
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension WaistCircumferenceRecordToDto on WaistCircumferenceRecord {
  WaistCircumferenceRecordDto toDto() {
    return WaistCircumferenceRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      circumference: LengthDto(
        unit: LengthUnitDto.meters,
        value: circumference.inMeters,
      ), // Manually wrap
    );
  }
}

@sinceV2_2_0
@internal
extension WaistCircumferenceRecordDtoToDomain on WaistCircumferenceRecordDto {
  WaistCircumferenceRecord toDomain() {
    return WaistCircumferenceRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      circumference: LengthDtoToDomain(
        circumference,
      ).toDomain(), // usage of measurement_unit_mapper extension
    );
  }
}
