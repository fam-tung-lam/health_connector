import 'package:health_connector_core/health_connector_core.dart'
    show HydrationRecord, Volume, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show HydrationRecordDto, VolumeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HydrationRecord] to [HydrationRecordDto].
@internal
extension HydrationRecordToDto on HydrationRecord {
  HydrationRecordDto toDto() {
    return HydrationRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      zoneOffsetSeconds: startZoneOffsetSeconds,

      metadata: metadata.toDto(),
      volume: volume.toDto() as VolumeDto,
    );
  }
}

/// Converts [HydrationRecordDto] to [HydrationRecord].
@internal
extension HydrationRecordDtoToDomain on HydrationRecordDto {
  HydrationRecord toDomain() {
    return HydrationRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: zoneOffsetSeconds,
      endZoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: volume.toDomain() as Volume,
    );
  }
}
