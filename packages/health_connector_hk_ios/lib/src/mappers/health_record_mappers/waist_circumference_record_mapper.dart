import 'package:health_connector_core/health_connector_core_internal.dart'
    show WaistCircumferenceRecord, HealthRecordId, Length;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show WaistCircumferenceRecordDto;
import 'package:meta/meta.dart' show internal;
@internal
extension WaistCircumferenceRecordToDto on WaistCircumferenceRecord {
  WaistCircumferenceRecordDto toDto() {
    return WaistCircumferenceRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      meters: circumference.inMeters,
    );
  }
}
@internal
extension WaistCircumferenceRecordDtoToDomain on WaistCircumferenceRecordDto {
  WaistCircumferenceRecord toDomain() {
    return WaistCircumferenceRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      circumference: Length.meters(meters),
    );
  }
}
