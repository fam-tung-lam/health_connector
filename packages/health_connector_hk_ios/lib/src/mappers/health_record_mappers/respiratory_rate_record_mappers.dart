import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Mapper extensions for [RespiratoryRateRecord].
@sinceV1_3_0
@internal
extension RespiratoryRateRecordToDto on RespiratoryRateRecord {
  /// Converts [RespiratoryRateRecord] to its [RespiratoryRateRecordDto].
  RespiratoryRateRecordDto toDto() {
    return RespiratoryRateRecordDto(
      id: id.toDto(),
      time: time.toUtc().millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      breathsPerMin: breathsPerMin.toDto(),
    );
  }
}

/// Mapper extensions for [RespiratoryRateRecordDto].
@sinceV1_3_0
@internal
extension RespiratoryRateRecordDtoToDomain on RespiratoryRateRecordDto {
  /// Converts [RespiratoryRateRecordDto] to its domain representation.
  RespiratoryRateRecord toDomain() {
    return RespiratoryRateRecord(
      id: HealthRecordId(id ?? HealthRecordId.none.value),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      breathsPerMin: Number(breathsPerMin.value),
    );
  }
}
