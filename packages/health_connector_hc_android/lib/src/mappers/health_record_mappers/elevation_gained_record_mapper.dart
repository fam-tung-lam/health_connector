import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [ElevationGainedRecord] to [ElevationGainedRecordDto].
@sinceV3_1_0
@internal
extension ElevationGainedRecordToDto on ElevationGainedRecord {
  ElevationGainedRecordDto toDto() {
    return ElevationGainedRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      meters: elevation.inMeters,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [ElevationGainedRecordDto] to [ElevationGainedRecord].
@sinceV3_1_0
@internal
extension ElevationGainedRecordDtoToDomain on ElevationGainedRecordDto {
  ElevationGainedRecord toDomain() {
    return ElevationGainedRecord.internal(
      id: HealthRecordId(id!),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      elevation: Length.meters(meters),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
