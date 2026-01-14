import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DateTimeToDto,
        HealthRecordId,
        Length,
        WalkingRunningDistanceRecord,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [WalkingRunningDistanceRecord] to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension WalkingRunningDistanceRecordToDto on WalkingRunningDistanceRecord {
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
      meters: distance.inMeters,
      activityType: DistanceActivityTypeDto.walkingRunning,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [WalkingRunningDistanceRecord].
@sinceV2_0_0
@internal
extension WalkingRunningDistanceRecordDtoToDomain on DistanceActivityRecordDto {
  WalkingRunningDistanceRecord toDomain() {
    return WalkingRunningDistanceRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      distance: Length.meters(meters),
    );
  }
}
