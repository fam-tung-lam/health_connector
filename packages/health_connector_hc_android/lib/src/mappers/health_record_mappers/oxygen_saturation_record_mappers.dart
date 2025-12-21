import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Mapper extensions for [OxygenSaturationRecord].
@sinceV1_3_0
@internal
extension OxygenSaturationRecordToDto on OxygenSaturationRecord {
  /// Converts [OxygenSaturationRecord] to its [OxygenSaturationRecordDto].
  OxygenSaturationRecordDto toDto() {
    return OxygenSaturationRecordDto(
      id: id.toDto(),
      time: time.toUtc().millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      percentage: percentage.toDto(),
    );
  }
}

/// Mapper extensions for [OxygenSaturationRecordDto].
@sinceV1_3_0
@internal
extension OxygenSaturationRecordDtoToDomain on OxygenSaturationRecordDto {
  /// Converts [OxygenSaturationRecordDto] to its domain representation.
  OxygenSaturationRecord toDomain() {
    return OxygenSaturationRecord(
      id: HealthRecordId(id ?? HealthRecordId.none.value),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: percentage.toDomain(),
    );
  }
}
