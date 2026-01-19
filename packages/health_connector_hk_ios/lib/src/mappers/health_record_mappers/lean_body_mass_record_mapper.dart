import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, LeanBodyMassRecord, Mass;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show LeanBodyMassRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [LeanBodyMassRecord] to [LeanBodyMassRecordDto].
@internal
extension LeanBodyMassRecordToDto on LeanBodyMassRecord {
  LeanBodyMassRecordDto toDto() {
    return LeanBodyMassRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      kilograms: mass.inKilograms,
    );
  }
}

/// Converts [LeanBodyMassRecordDto] to [LeanBodyMassRecord].
@internal
extension LeanBodyMassRecordDtoToDomain on LeanBodyMassRecordDto {
  LeanBodyMassRecord toDomain() {
    return LeanBodyMassRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: Mass.kilograms(kilograms),
    );
  }
}
