import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPowerRecord, HealthRecordId, sinceV2_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show CyclingPowerRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPowerRecord] to [CyclingPowerRecordDto].
@sinceV2_1_0
@internal
extension CyclingPowerRecordToDto on CyclingPowerRecord {
  CyclingPowerRecordDto toDto() {
    return CyclingPowerRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      power: power.toDto(),
    );
  }
}

/// Converts [CyclingPowerRecordDto] to [CyclingPowerRecord].
@sinceV2_1_0
@internal
extension CyclingPowerRecordDtoToDomain on CyclingPowerRecordDto {
  CyclingPowerRecord toDomain() {
    return CyclingPowerRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      power: power.toDomain(),
    );
  }
}
