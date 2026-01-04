import 'package:health_connector_core/health_connector_core_internal.dart'
    show CrossCountrySkiingDistanceRecord, HealthRecordId, sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CrossCountrySkiingDistanceRecord] to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension CrossCountrySkiingDistanceRecordToDto
    on CrossCountrySkiingDistanceRecord {
  DistanceActivityRecordDto toDto() {
    return DistanceActivityRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      zoneOffsetSeconds: startZoneOffsetSeconds,
      metadata: metadata.toDto(),
      distance: distance.toDto(),
      activityType: DistanceActivityTypeDto.crossCountrySkiing,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [CrossCountrySkiingDistanceRecord].
@sinceV2_0_0
@internal
extension CrossCountrySkiingDistanceRecordDtoToDomain
    on DistanceActivityRecordDto {
  CrossCountrySkiingDistanceRecord toDomain() {
    return CrossCountrySkiingDistanceRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: zoneOffsetSeconds,
      endZoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      distance: distance.toDomain(),
    );
  }
}
