import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DateTimeToDto,
        HealthRecordId,
        Length,
        RowingDistanceRecord,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RowingDistanceRecord] to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension RowingDistanceRecordToDto on RowingDistanceRecord {
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
      activityType: DistanceActivityTypeDto.rowing,
    );
  }
}

/// Converts [DistanceActivityRecordDto] to [RowingDistanceRecord].
@sinceV2_0_0
@internal
extension RowingDistanceRecordDtoToDomain on DistanceActivityRecordDto {
  RowingDistanceRecord toDomain() {
    return RowingDistanceRecord.internal(
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
