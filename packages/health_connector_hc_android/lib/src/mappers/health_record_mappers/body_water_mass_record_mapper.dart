import 'package:health_connector_core/health_connector_core_internal.dart'
    show BodyWaterMassRecord, HealthRecordId, sinceV2_2_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BodyWaterMassRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BodyWaterMassRecord] to [BodyWaterMassRecordDto].
@sinceV2_2_0
@internal
extension BodyWaterMassRecordToDto on BodyWaterMassRecord {
  BodyWaterMassRecordDto toDto() {
    return BodyWaterMassRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      mass: mass.toDto(),
    );
  }
}

/// Converts [BodyWaterMassRecordDto] to [BodyWaterMassRecord].
@sinceV2_2_0
@internal
extension BodyWaterMassRecordDtoToDomain on BodyWaterMassRecordDto {
  BodyWaterMassRecord toDomain() {
    return BodyWaterMassRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: mass.toDomain(),
    );
  }
}
