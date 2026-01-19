import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [ExerciseTimeRecord] to [ExerciseTimeRecordDto].
@internal
extension ExerciseTimeRecordToDto on ExerciseTimeRecord {
  ExerciseTimeRecordDto toDto() {
    return ExerciseTimeRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      seconds: exerciseTime.inSeconds,
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [ExerciseTimeRecordDto] to [ExerciseTimeRecord].
@internal
extension ExerciseTimeRecordDtoToDomain on ExerciseTimeRecordDto {
  ExerciseTimeRecord toDomain() {
    return ExerciseTimeRecord.internal(
      id: HealthRecordId(id ?? ''),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      exerciseTime: TimeDuration.seconds(seconds),
    );
  }
}
