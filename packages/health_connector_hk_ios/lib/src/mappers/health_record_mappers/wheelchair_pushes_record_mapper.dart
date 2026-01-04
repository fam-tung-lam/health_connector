import 'package:health_connector_core/health_connector_core_internal.dart'
    show WheelchairPushesRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show WheelchairPushesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [WheelchairPushesRecord] to [WheelchairPushesRecordDto].
@sinceV1_0_0
@internal
extension WheelchairPushesRecordToDto on WheelchairPushesRecord {
  WheelchairPushesRecordDto toDto() {
    return WheelchairPushesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      zoneOffsetSeconds: startZoneOffsetSeconds,
      metadata: metadata.toDto(),
      pushes: pushes.toDto(),
    );
  }
}

/// Converts [WheelchairPushesRecordDto] to [WheelchairPushesRecord].
@sinceV1_0_0
@internal
extension WheelchairPushesRecordDtoToDomain on WheelchairPushesRecordDto {
  WheelchairPushesRecord toDomain() {
    return WheelchairPushesRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: zoneOffsetSeconds,
      endZoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pushes: pushes.toDomain(),
    );
  }
}
