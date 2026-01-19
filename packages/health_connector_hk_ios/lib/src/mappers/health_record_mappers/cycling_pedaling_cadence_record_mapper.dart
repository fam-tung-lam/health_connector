import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPedalingCadenceRecord, Frequency, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show CyclingPedalingCadenceRecordDto;
import 'package:meta/meta.dart' show internal;

@internal
extension CyclingPedalingCadenceRecordToDto on CyclingPedalingCadenceRecord {
  CyclingPedalingCadenceRecordDto toDto() {
    return CyclingPedalingCadenceRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      revolutionsPerMinute: cadence.inPerMinute,
    );
  }
}

@internal
extension CyclingPedalingCadenceRecordDtoToDomain
    on CyclingPedalingCadenceRecordDto {
  CyclingPedalingCadenceRecord toDomain() {
    return CyclingPedalingCadenceRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      cadence: Frequency.perMinute(revolutionsPerMinute),
    );
  }
}
