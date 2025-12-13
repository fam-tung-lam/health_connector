import 'package:health_connector_core/health_connector_core.dart'
    show HydrationRecord, Volume, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HydrationRecordDto, VolumeDto;
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
      volume: volume.toDto() as VolumeDto,
    );
  }
}

/// Converts [HydrationRecordDto] to [HydrationRecord].
@sinceV1_0_0
@internal
extension HydrationRecordDtoToDomain on HydrationRecordDto {
  HydrationRecord toDomain() {
    return HydrationRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: volume.toDomain() as Volume,
    );
  }
}
