import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_route_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_session_event_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Extension to convert [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
@internal
extension ExerciseSessionRecordToDto on ExerciseSessionRecord {
  ExerciseSessionRecordDto toDto() {
    return ExerciseSessionRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.timeZoneOffset.inSeconds,
      endZoneOffsetSeconds: endTime.timeZoneOffset.inSeconds,
      exerciseType: exerciseType.toDto(),
      title: title,
      notes: notes,
      events: events.map((e) => e.toDto()).toList(),
      exerciseRoute: exerciseRoute?.toDto(),
    );
  }
}

/// Extension to convert [ExerciseSessionRecordDto] to [ExerciseSessionRecord].
@internal
extension ExerciseSessionRecordFromDto on ExerciseSessionRecordDto {
  ExerciseSessionRecord fromDto() {
    return ExerciseSessionRecord.internal(
      id: id.toDomain(),
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ),
      exerciseType: exerciseType.fromDto(),
      title: title,
      notes: notes,
      events: events.map((e) => e.toDomain()).toList(),
      exerciseRoute: exerciseRoute?.toDomain(),
    );
  }
}
