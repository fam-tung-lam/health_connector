import 'package:health_connector_core/health_connector_core_internal.dart'
    show DistanceRecord, HealthRecordId, sinceV1_0_0, DateTimeToDto;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show DistanceRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DistanceRecord] to [DistanceRecordDto].
@sinceV1_0_0
@internal
extension DistanceRecordToDto on DistanceRecord {
  DistanceRecordDto toDto() {
    return DistanceRecordDto(
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
    );
  }
}

/// Converts [DistanceRecordDto] to [DistanceRecord].
@sinceV1_0_0
@internal
extension DistanceRecordDtoToDomain on DistanceRecordDto {
  DistanceRecord toDomain() {
    return DistanceRecord(
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
