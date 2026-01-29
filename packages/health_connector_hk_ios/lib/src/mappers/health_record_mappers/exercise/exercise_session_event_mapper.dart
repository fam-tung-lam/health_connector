import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ExerciseSessionLapEvent,
        ExerciseSessionMarkerEvent,
        ExerciseSessionSegmentEvent,
        ExerciseSessionEvent,
        ExerciseSessionStateTransitionEvent,
        Length;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_segment_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        ExerciseSessionLapEventDto,
        ExerciseSessionMarkerEventDto,
        ExerciseSessionSegmentEventDto,
        ExerciseSessionEventDto,
        ExerciseSessionStateTransitionEventDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ExerciseSessionEvent] to [ExerciseSessionEventDto].
@internal
extension ExerciseSessionEventToDto on ExerciseSessionEvent {
  ExerciseSessionEventDto toDto() {
    return switch (this) {
      ExerciseSessionStateTransitionEvent(:final time, :final type) =>
        ExerciseSessionStateTransitionEventDto(
          time: time.millisecondsSinceEpoch,
          type: type.toDto(),
        ),
      ExerciseSessionMarkerEvent(:final time) => ExerciseSessionMarkerEventDto(
        time: time.millisecondsSinceEpoch,
      ),
      ExerciseSessionLapEvent(
        :final startTime,
        :final endTime,
        :final distance,
      ) =>
        ExerciseSessionLapEventDto(
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
          distanceMeters: distance?.inMeters,
        ),
      ExerciseSessionSegmentEvent(
        :final startTime,
        :final endTime,
        :final segmentType,
        :final repetitions,
      ) =>
        ExerciseSessionSegmentEventDto(
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
          segmentType: segmentType.toDto(),
          repetitions: repetitions,
        ),
    };
  }
}

/// Converts [ExerciseSessionEventDto] to [ExerciseSessionEvent].
@internal
extension ExerciseSessionEventDtoToDomain on ExerciseSessionEventDto {
  ExerciseSessionEvent toDomain() {
    return switch (this) {
      ExerciseSessionStateTransitionEventDto(:final time, :final type) =>
        ExerciseSessionStateTransitionEvent(
          time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
          type: type.toDomain(),
        ),
      ExerciseSessionMarkerEventDto(:final time) => ExerciseSessionMarkerEvent(
        time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      ),
      ExerciseSessionLapEventDto(
        :final startTime,
        :final endTime,
        :final distanceMeters,
      ) =>
        ExerciseSessionLapEvent(
          startTime: DateTime.fromMillisecondsSinceEpoch(
            startTime,
            isUtc: true,
          ),
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
          distance: distanceMeters != null
              ? Length.meters(distanceMeters)
              : null,
        ),
      ExerciseSessionSegmentEventDto(
        :final startTime,
        :final endTime,
        :final segmentType,
        :final repetitions,
      ) =>
        ExerciseSessionSegmentEvent(
          startTime: DateTime.fromMillisecondsSinceEpoch(
            startTime,
            isUtc: true,
          ),
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
          segmentType: segmentType.toDomain(),
          repetitions: repetitions,
        ),
    };
  }
}
