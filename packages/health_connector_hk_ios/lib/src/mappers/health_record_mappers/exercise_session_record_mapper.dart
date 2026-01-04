import 'package:health_connector_core/health_connector_core_internal.dart'
    show ExerciseSessionRecord, HealthRecordId, sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ExerciseSessionRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
@sinceV2_0_0
@internal
extension ExerciseSessionRecordToDto on ExerciseSessionRecord {
  ExerciseSessionRecordDto toDto() {
    return ExerciseSessionRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      exerciseType: exerciseType.toDto(),
      title: title,
      notes: notes,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [ExerciseSessionRecordDto] to [ExerciseSessionRecord].
@sinceV2_0_0
@internal
extension ExerciseSessionRecordDtoToDomain on ExerciseSessionRecordDto {
  ExerciseSessionRecord toDomain() {
    return ExerciseSessionRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      exerciseType: exerciseType.toDomain(),
      title: title,
      notes: notes,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
