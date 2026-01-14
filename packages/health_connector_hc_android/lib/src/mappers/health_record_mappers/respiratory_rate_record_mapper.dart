import 'package:health_connector_core/health_connector_core_internal.dart'
    show RespiratoryRateRecord, HealthRecordId, sinceV1_3_0, Frequency;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
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
      breathsPerMinute: rate.inPerMinute,
    );
  }
}

/// Mapper extensions for [RespiratoryRateRecordDto].
@sinceV1_3_0
@internal
extension RespiratoryRateRecordDtoToDomain on RespiratoryRateRecordDto {
  /// Converts [RespiratoryRateRecordDto] to its domain representation.
  RespiratoryRateRecord toDomain() {
    return RespiratoryRateRecord.internal(
      id: id != null ? HealthRecordId(id!) : HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: Frequency.perMinute(breathsPerMinute),
    );
  }
}
