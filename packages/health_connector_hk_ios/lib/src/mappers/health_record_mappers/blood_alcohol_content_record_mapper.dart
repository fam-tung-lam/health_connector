import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodAlcoholContentRecord, HealthRecordId, Percentage;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodAlcoholContentRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodAlcoholContentRecord] to [BloodAlcoholContentRecordDto].
@internal
extension BloodAlcoholContentRecordToDto on BloodAlcoholContentRecord {
  BloodAlcoholContentRecordDto toDto() {
    return BloodAlcoholContentRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      percentage: percentage.asDecimal,
    );
  }
}

/// Converts [BloodAlcoholContentRecordDto] to [BloodAlcoholContentRecord].
@internal
extension BloodAlcoholContentRecordDtoToDomain on BloodAlcoholContentRecordDto {
  BloodAlcoholContentRecord toDomain() {
    return BloodAlcoholContentRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: Percentage.fromDecimal(percentage),
    );
  }
}
