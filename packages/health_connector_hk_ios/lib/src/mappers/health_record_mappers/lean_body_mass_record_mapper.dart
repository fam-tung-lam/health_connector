import 'package:health_connector_core/health_connector_core_internal.dart'
    show LeanBodyMassRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show LeanBodyMassRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [LeanBodyMassRecord] to [LeanBodyMassRecordDto].
@sinceV1_0_0
@internal
extension LeanBodyMassRecordToDto on LeanBodyMassRecord {
  LeanBodyMassRecordDto toDto() {
    return LeanBodyMassRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      mass: mass.toDto(),
    );
  }
}

/// Converts [LeanBodyMassRecordDto] to [LeanBodyMassRecord].
@sinceV1_0_0
@internal
extension LeanBodyMassRecordDtoToDomain on LeanBodyMassRecordDto {
  LeanBodyMassRecord toDomain() {
    return LeanBodyMassRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: mass.toDomain(),
    );
  }
}
