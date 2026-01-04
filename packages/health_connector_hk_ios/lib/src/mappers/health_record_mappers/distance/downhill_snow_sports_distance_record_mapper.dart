import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DownhillSnowSportsDistanceRecord,
        HealthRecordId,
        sinceV2_0_0,
        DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DownhillSnowSportsDistanceRecord] to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension DownhillSnowSportsDistanceRecordToDto
    on DownhillSnowSportsDistanceRecord {
  DistanceActivityRecordDto toDto() {
    return DistanceActivityRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      metadata: metadata.toDto(),
      distance: distance.toDto(),
      activityType: DistanceActivityTypeDto.downhillSnowSports,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [DownhillSnowSportsDistanceRecord].
@sinceV2_0_0
@internal
extension DownhillSnowSportsDistanceRecordDtoToDomain
    on DistanceActivityRecordDto {
  DownhillSnowSportsDistanceRecord toDomain() {
    return DownhillSnowSportsDistanceRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      distance: distance.toDomain(),
    );
  }
}
