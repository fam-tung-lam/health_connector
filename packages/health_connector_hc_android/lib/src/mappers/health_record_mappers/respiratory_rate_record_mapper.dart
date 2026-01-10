import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
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
      breathsPerMin: rate.toDto(),
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
      id: id != null ? HealthRecordId(id!) : HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: breathsPerMin.toDomain(),
    );
  }
}
