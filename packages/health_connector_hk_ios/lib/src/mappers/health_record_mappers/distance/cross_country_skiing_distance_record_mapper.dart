import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        CrossCountrySkiingDistanceRecord,
        DateTimeToDto,
        HealthRecordId,
        Length;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CrossCountrySkiingDistanceRecord] to [DistanceActivityRecordDto].
@internal
extension CrossCountrySkiingDistanceRecordToDto
    on CrossCountrySkiingDistanceRecord {
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
      activityType: DistanceActivityTypeDto.crossCountrySkiing,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [CrossCountrySkiingDistanceRecord].
@internal
extension CrossCountrySkiingDistanceRecordDtoToDomain
    on DistanceActivityRecordDto {
  CrossCountrySkiingDistanceRecord toDomain() {
    return CrossCountrySkiingDistanceRecord.internal(
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
