import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateVariabilityRMSSDRecord, HealthRecordId, Number, sinceV2_2_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HeartRateVariabilityRMSSDRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateVariabilityRMSSDRecord] to
/// [HeartRateVariabilityRMSSDRecordDto].
@sinceV2_2_0
@internal
extension HeartRateVariabilityRMSSDRecordToDto
    on HeartRateVariabilityRMSSDRecord {
  HeartRateVariabilityRMSSDRecordDto toDto() {
    return HeartRateVariabilityRMSSDRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      heartRateVariabilityMillis: heartRateVariabilityMillis.value.toDouble(),
    );
  }
}

/// Converts [HeartRateVariabilityRMSSDRecordDto] to
/// [HeartRateVariabilityRMSSDRecord].
@sinceV2_2_0
@internal
extension HeartRateVariabilityRMSSDRecordDtoToDomain
    on HeartRateVariabilityRMSSDRecordDto {
  HeartRateVariabilityRMSSDRecord toDomain() {
    return HeartRateVariabilityRMSSDRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      heartRateVariabilityMillis: Number(heartRateVariabilityMillis),
    );
  }
}
