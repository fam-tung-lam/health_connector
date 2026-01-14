import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        CyclingDistanceRecord,
        DateTimeToDto,
        HealthRecordId,
        Length,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingDistanceRecord] to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension CyclingDistanceRecordToDto on CyclingDistanceRecord {
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
      activityType: DistanceActivityTypeDto.cycling,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [CyclingDistanceRecord].
@sinceV2_0_0
@internal
extension CyclingDistanceRecordDtoToDomain on DistanceActivityRecordDto {
  CyclingDistanceRecord toDomain() {
    return CyclingDistanceRecord.internal(
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
