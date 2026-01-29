import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_session_event_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group('ExerciseSessionEventMapper', () {
    test('throws UnsupportedError for ExerciseSessionStateTransitionEvent', () {
      final event = ExerciseSessionStateTransitionEvent(
        time: DateTime.now(),
        type: ExerciseSessionStateTransitionType.pause,
      );

      expect(event.toDto, throwsUnsupportedError);
    });

    test('throws UnsupportedError for ExerciseSessionMarkerEvent', () {
      final event = ExerciseSessionMarkerEvent(time: DateTime.now());

      expect(event.toDto, throwsUnsupportedError);
    });

    test('converts ExerciseSessionLapEvent to/from DTO', () {
      final startTime = DateTime(2023, 1, 1, 10).toUtc();
      final endTime = DateTime(2023, 1, 1, 10, 30).toUtc();
      final event = ExerciseSessionLapEvent(
        startTime: startTime,
        endTime: endTime,
        distance: const Length.meters(100),
      );

      final dto = event.toDto() as ExerciseSessionLapEventDto;
      expect(dto.startTime, startTime.millisecondsSinceEpoch);
      expect(dto.endTime, endTime.millisecondsSinceEpoch);
      expect(dto.distanceMeters, 100.0);

      final domain = dto.toDomain() as ExerciseSessionLapEvent;
      expect(domain.startTime, startTime);
      expect(domain.endTime, endTime);
      expect(domain.distance, const Length.meters(100));
    });

    test('converts ExerciseSessionSegmentEvent to/from DTO', () {
      final startTime = DateTime(2023, 1, 1, 10).toUtc();
      final endTime = DateTime(2023, 1, 1, 10, 30).toUtc();
      final event = ExerciseSessionSegmentEvent(
        startTime: startTime,
        endTime: endTime,
        segmentType: ExerciseSegmentType.running,
        repetitions: 10,
      );

      final dto = event.toDto() as ExerciseSessionSegmentEventDto;
      expect(dto.startTime, startTime.millisecondsSinceEpoch);
      expect(dto.endTime, endTime.millisecondsSinceEpoch);
      expect(dto.segmentType, ExerciseSegmentTypeDto.running);
      expect(dto.repetitions, 10);

      final domain = dto.toDomain() as ExerciseSessionSegmentEvent;
      expect(domain.startTime, startTime);
      expect(domain.endTime, endTime);
      expect(domain.segmentType, ExerciseSegmentType.running);
      expect(domain.repetitions, 10);
    });
  });
}
