import 'package:health_connector_core/health_connector_core_internal.dart'
    show HydrationRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HydrationRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HydrationRecord] to [HydrationRecordDto].
@sinceV1_0_0
@internal
extension HydrationRecordToDto on HydrationRecord {
  HydrationRecordDto toDto() {
    return HydrationRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      volume: volume.toDto(),
    );
  }
}

/// Converts [HydrationRecordDto] to [HydrationRecord].
@sinceV1_0_0
@internal
extension HydrationRecordDtoToDomain on HydrationRecordDto {
  HydrationRecord toDomain() {
    return HydrationRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: volume.toDomain(),
    );
  }
}
