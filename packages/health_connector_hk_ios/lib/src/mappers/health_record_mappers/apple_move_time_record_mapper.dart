import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [AppleMoveTimeRecord] to [AppleMoveTimeRecordDto].
@internal
extension AppleMoveTimeRecordToDto on AppleMoveTimeRecord {
  AppleMoveTimeRecordDto toDto() {
    return AppleMoveTimeRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      seconds: moveTime.inSeconds,
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [AppleMoveTimeRecordDto] to [AppleMoveTimeRecord].
@internal
extension AppleMoveTimeRecordDtoToDomain on AppleMoveTimeRecordDto {
  AppleMoveTimeRecord toDomain() {
    return AppleMoveTimeRecord.internal(
      id: HealthRecordId(id ?? ''),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      moveTime: TimeDuration.seconds(seconds),
    );
  }
}
