import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show CyclingPedalingCadenceRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPedalingCadenceRecord] to
/// [CyclingPedalingCadenceRecordDto].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementRecordToDto
    on CyclingPedalingCadenceRecord {
  CyclingPedalingCadenceRecordDto toDto() {
    return CyclingPedalingCadenceRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      revolutionsPerMinute: cadence.inPerMinute,
    );
  }
}

/// Converts [CyclingPedalingCadenceRecordDto] to
/// [CyclingPedalingCadenceRecord].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementRecordDtoToDomain
    on CyclingPedalingCadenceRecordDto {
  CyclingPedalingCadenceRecord toDomain() {
    return CyclingPedalingCadenceRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      cadence: Frequency.perMinute(revolutionsPerMinute),
    );
  }
}
