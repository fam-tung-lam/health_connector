import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

/// Extension to convert [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
extension ExerciseSessionRecordToDto on ExerciseSessionRecord {
  /// Converts [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
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
    );
  }
}

/// Extension to convert [ExerciseSessionRecordDto] to [ExerciseSessionRecord].
extension ExerciseSessionRecordFromDto on ExerciseSessionRecordDto {
  /// Converts [ExerciseSessionRecordDto] to [ExerciseSessionRecord].
  ExerciseSessionRecord fromDto() {
    return ExerciseSessionRecord(
      id: id != null ? HealthRecordId(id!) : HealthRecordId.none,
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
    );
  }
}
