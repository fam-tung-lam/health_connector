import 'package:health_connector_core/health_connector_core_internal.dart'
    show RunningPowerRecord, HealthRecordId, Power;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show RunningPowerRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RunningPowerRecord] to [RunningPowerRecordDto].
@internal
extension RunningPowerRecordToDto on RunningPowerRecord {
  RunningPowerRecordDto toDto() {
    return RunningPowerRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      watts: power.inWatts,
    );
  }
}

/// Converts [RunningPowerRecordDto] to [RunningPowerRecord].
@internal
extension RunningPowerRecordDtoToDomain on RunningPowerRecordDto {
  RunningPowerRecord toDomain() {
    return RunningPowerRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      power: Power.watts(watts),
    );
  }
}
