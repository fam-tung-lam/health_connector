import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [AppleStandTimeRecord] to [AppleStandTimeRecordDto].
@internal
extension AppleStandTimeRecordToDto on AppleStandTimeRecord {
  AppleStandTimeRecordDto toDto() {
    return AppleStandTimeRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      seconds: standTime.inSeconds,
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [AppleStandTimeRecordDto] to [AppleStandTimeRecord].
@internal
extension AppleStandTimeRecordDtoToDomain on AppleStandTimeRecordDto {
  AppleStandTimeRecord toDomain() {
    return AppleStandTimeRecord.internal(
      id: HealthRecordId(id ?? ''),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      standTime: TimeDuration.seconds(seconds),
    );
  }
}
