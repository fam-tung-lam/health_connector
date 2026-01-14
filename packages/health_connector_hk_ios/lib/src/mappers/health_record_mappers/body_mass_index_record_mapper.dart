import 'package:health_connector_core/health_connector_core_internal.dart'
    show BodyMassIndexRecord, HealthRecordId, Number, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BodyMassIndexRecordDto;
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension BodyMassIndexRecordToDto on BodyMassIndexRecord {
  BodyMassIndexRecordDto toDto() {
    return BodyMassIndexRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      bodyMassIndex: bmi.value.toDouble(),
    );
  }
}

@sinceV2_2_0
@internal
extension BodyMassIndexRecordDtoToDomain on BodyMassIndexRecordDto {
  BodyMassIndexRecord toDomain() {
    return BodyMassIndexRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      bmi: Number(bodyMassIndex),
    );
  }
}
