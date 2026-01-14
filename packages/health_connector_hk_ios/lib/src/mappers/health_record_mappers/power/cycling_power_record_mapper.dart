import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPowerRecord, HealthRecordId, Power, sinceV2_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
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
      watts: power.inWatts,
    );
  }
}

/// Converts [CyclingPowerRecordDto] to [CyclingPowerRecord].
@sinceV2_1_0
@internal
extension CyclingPowerRecordDtoToDomain on CyclingPowerRecordDto {
  CyclingPowerRecord toDomain() {
    return CyclingPowerRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      power: Power.watts(watts),
    );
  }
}
