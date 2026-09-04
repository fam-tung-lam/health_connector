import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ExerciseSessionLapEvent,
        ExerciseSessionSegmentEvent,
        ExerciseSessionEvent,
        Length,
        Mass,
        ExerciseSessionStateTransitionEvent,
        ExerciseSessionMarkerEvent;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_segment_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        ExerciseSessionLapEventDto,
        ExerciseSessionSegmentEventDto,
        ExerciseSessionEventDto;
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ExerciseSessionEvent] to [ExerciseSessionEventDto].
@internal
extension ExerciseSessionEventToDto on ExerciseSessionEvent {
  ExerciseSessionEventDto toDto() {
    return switch (this) {
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
        :final weight,
        :final setIndex,
        :final rateOfPerceivedExertion,
      ) =>
        ExerciseSessionSegmentEventDto(
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
          segmentType: segmentType.toDto(),
          repetitions: repetitions,
          weightKg: weight?.inKilograms,
          setIndex: setIndex,
          rateOfPerceivedExertion: rateOfPerceivedExertion,
        ),
      ExerciseSessionStateTransitionEvent _ => throw UnsupportedError(
        '$ExerciseSessionStateTransitionEvent is not supported on '
        'Android Health Connect. Use $ExerciseSessionLapEvent and '
        '$ExerciseSessionSegmentEvent instead.',
      ),
      ExerciseSessionMarkerEvent _ => throw UnsupportedError(
        '$ExerciseSessionMarkerEvent is not supported on '
        'Android Health Connect. Use $ExerciseSessionLapEvent and '
        '$ExerciseSessionSegmentEvent instead.',
      ),
    };
  }
}

/// Extension to convert [ExerciseSessionEventDto] to [ExerciseSessionEvent].
@internal
extension ExerciseSessionEventDtoToDomain on ExerciseSessionEventDto {
  ExerciseSessionEvent toDomain() {
    return switch (this) {
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
        :final weightKg,
        :final setIndex,
        :final rateOfPerceivedExertion,
      ) =>
        ExerciseSessionSegmentEvent(
          startTime: DateTime.fromMillisecondsSinceEpoch(
            startTime,
            isUtc: true,
          ),
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
          segmentType: segmentType.toDomain(),
          repetitions: repetitions,
          weight: weightKg != null ? Mass.kilograms(weightKg) : null,
          setIndex: setIndex,
          rateOfPerceivedExertion: rateOfPerceivedExertion,
        ),
    };
  }
}
