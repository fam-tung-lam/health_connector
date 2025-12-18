import 'package:health_connector_core/health_connector_core.dart'
    show HealthRecordId, OxygenSaturationRecord, Percentage, sinceV1_3_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show OxygenSaturationRecordDto, PercentageDto;
import 'package:meta/meta.dart' show internal;

/// Converts [OxygenSaturationRecord] to [OxygenSaturationRecordDto].
@sinceV1_3_0
@internal
extension OxygenSaturationRecordToDto on OxygenSaturationRecord {
  OxygenSaturationRecordDto toDto() {
    return OxygenSaturationRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      percentage: percentage.toDto() as PercentageDto,
    );
  }
}

/// Converts [OxygenSaturationRecordDto] to [OxygenSaturationRecord].
@sinceV1_3_0
@internal
extension OxygenSaturationRecordDtoToDomain on OxygenSaturationRecordDto {
  OxygenSaturationRecord toDomain() {
    return OxygenSaturationRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: percentage.toDomain() as Percentage,
    );
  }
}
