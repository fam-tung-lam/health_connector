import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [MoveTimeRecord] to [MoveTimeRecordDto].
@internal
extension MoveTimeRecordToDto on MoveTimeRecord {
  MoveTimeRecordDto toDto() {
    return MoveTimeRecordDto(
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

/// Converts [MoveTimeRecordDto] to [MoveTimeRecord].
@internal
extension MoveTimeRecordDtoToDomain on MoveTimeRecordDto {
  MoveTimeRecord toDomain() {
    return MoveTimeRecord.internal(
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
