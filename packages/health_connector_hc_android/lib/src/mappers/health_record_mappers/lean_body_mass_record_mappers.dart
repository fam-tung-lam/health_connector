import 'package:health_connector_core/health_connector_core.dart'
    show LeanBodyMassRecord, Mass, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show LeanBodyMassRecordDto, MassDto;
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
      mass: mass.toDto() as MassDto,
    );
  }
}

/// Converts [LeanBodyMassRecordDto] to [LeanBodyMassRecord].
@sinceV1_0_0
@internal
extension LeanBodyMassRecordDtoToDomain on LeanBodyMassRecordDto {
  LeanBodyMassRecord toDomain() {
    return LeanBodyMassRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: mass.toDomain() as Mass,
    );
  }
}
