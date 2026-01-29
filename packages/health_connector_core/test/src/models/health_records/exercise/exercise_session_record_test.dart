import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ExerciseSessionRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const exerciseType = ExerciseType.running;
    const title = 'Morning Run';
    const notes = 'Good pace';

    test('can be instantiated with valid parameters', () {
      final record = ExerciseSessionRecord(
        startTime: startTime,
        endTime: endTime,
        exerciseType: exerciseType,
        metadata: metadata,
        title: title,
        notes: notes,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.exerciseType, exerciseType);
      expect(record.metadata, metadata);
      expect(record.title, title);
      expect(record.notes, notes);
    });

    test('throws ArgumentError when startTime is after endTime', () {
      expect(
        () => ExerciseSessionRecord(
          startTime: endTime,
          endTime: startTime,
          exerciseType: exerciseType,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = ExerciseSessionRecord(
        startTime: startTime,
        endTime: endTime,
        exerciseType: exerciseType,
        metadata: metadata,
        title: title,
        notes: notes,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      final newEndTime = endTime.add(const Duration(minutes: 10));
      const newType = ExerciseType.cycling;
      const newTitle = 'Evening Ride';
      const newNotes = 'Windy';
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        exerciseType: newType,
        title: newTitle,
        notes: newNotes,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime.toUtc());
      expect(updatedRecord.endTime, newEndTime.toUtc());
      expect(updatedRecord.exerciseType, newType);
      expect(updatedRecord.title, newTitle);
      expect(updatedRecord.notes, newNotes);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ExerciseSessionRecord(
        startTime: startTime,
        endTime: endTime,
        exerciseType: exerciseType,
        metadata: metadata,
        title: title,
        notes: notes,
      );

      final record2 = ExerciseSessionRecord(
        startTime: startTime,
        endTime: endTime,
        exerciseType: exerciseType,
        metadata: metadata,
        title: title,
        notes: notes,
      );

      final record3 = ExerciseSessionRecord(
        startTime: startTime,
        endTime: endTime,
        exerciseType: ExerciseType.cycling,
        metadata: metadata,
        title: title,
        notes: notes,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    group('event validation', () {
      test(
        'accepts valid non-overlapping lap and '
        'segment events within time range',
        () {
          final lap1Start = startTime.add(const Duration(minutes: 5));
          final lap1End = startTime.add(const Duration(minutes: 10));
          final lap2Start = startTime.add(const Duration(minutes: 15));
          final lap2End = startTime.add(const Duration(minutes: 20));
          final segmentStart = startTime.add(const Duration(minutes: 25));
          final segmentEnd = startTime.add(const Duration(minutes: 35));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: exerciseType,
              metadata: metadata,
              events: [
                ExerciseSessionLapEvent(startTime: lap1Start, endTime: lap1End),
                ExerciseSessionLapEvent(startTime: lap2Start, endTime: lap2End),
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.running,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'throws ArgumentError when lap event is outside session time range',
        () {
          final beforeSession = startTime.subtract(const Duration(minutes: 5));
          final lapEnd = startTime.add(const Duration(minutes: 5));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: exerciseType,
              metadata: metadata,
              events: [
                ExerciseSessionLapEvent(
                  startTime: beforeSession,
                  endTime: lapEnd,
                ),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'throws ArgumentError when segment event is outside session time range',
        () {
          final segmentStart = endTime.subtract(const Duration(minutes: 5));
          final afterSession = endTime.add(const Duration(minutes: 5));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: exerciseType,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: afterSession,
                  segmentType: ExerciseSegmentType.running,
                ),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'throws ArgumentError when instant event is outside session time range',
        () {
          final beforeSession = startTime.subtract(const Duration(minutes: 1));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: exerciseType,
              metadata: metadata,
              events: [
                ExerciseSessionMarkerEvent(time: beforeSession),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test('throws ArgumentError when lap events overlap', () {
        final lap1Start = startTime.add(const Duration(minutes: 5));
        final lap1End = startTime.add(const Duration(minutes: 15));
        final lap2Start = startTime.add(const Duration(minutes: 10));
        final lap2End = startTime.add(const Duration(minutes: 20));

        expect(
          () => ExerciseSessionRecord(
            startTime: startTime,
            endTime: endTime,
            exerciseType: exerciseType,
            metadata: metadata,
            events: [
              ExerciseSessionLapEvent(startTime: lap1Start, endTime: lap1End),
              ExerciseSessionLapEvent(startTime: lap2Start, endTime: lap2End),
            ],
          ),
          throwsArgumentError,
        );
      });

      test('throws ArgumentError when segment events overlap', () {
        final seg1Start = startTime.add(const Duration(minutes: 5));
        final seg1End = startTime.add(const Duration(minutes: 15));
        final seg2Start = startTime.add(const Duration(minutes: 10));
        final seg2End = startTime.add(const Duration(minutes: 25));

        expect(
          () => ExerciseSessionRecord(
            startTime: startTime,
            endTime: endTime,
            exerciseType: exerciseType,
            metadata: metadata,
            events: [
              ExerciseSessionSegmentEvent(
                startTime: seg1Start,
                endTime: seg1End,
                segmentType: ExerciseSegmentType.running,
              ),
              ExerciseSessionSegmentEvent(
                startTime: seg2Start,
                endTime: seg2End,
                segmentType: ExerciseSegmentType.walking,
              ),
            ],
          ),
          throwsArgumentError,
        );
      });

      test('throws ArgumentError when marker events have the same time', () {
        final t = startTime.add(const Duration(minutes: 10));

        expect(
          () => ExerciseSessionRecord(
            startTime: startTime,
            endTime: endTime,
            exerciseType: exerciseType,
            metadata: metadata,
            events: [
              ExerciseSessionMarkerEvent(time: t),
              ExerciseSessionMarkerEvent(time: t),
            ],
          ),
          throwsArgumentError,
        );
      });

      test(
        'throws ArgumentError when state transition events have the same time',
        () {
          final t = startTime.add(const Duration(minutes: 10));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: exerciseType,
              metadata: metadata,
              events: [
                ExerciseSessionStateTransitionEvent(
                  time: t,
                  type: ExerciseSessionStateTransitionType.pause,
                ),
                ExerciseSessionStateTransitionEvent(
                  time: t,
                  type: ExerciseSessionStateTransitionType.resume,
                ),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test('accepts marker events with different times', () {
        final t1 = startTime.add(const Duration(minutes: 5));
        final t2 = startTime.add(const Duration(minutes: 15));

        expect(
          () => ExerciseSessionRecord(
            startTime: startTime,
            endTime: endTime,
            exerciseType: exerciseType,
            metadata: metadata,
            events: [
              ExerciseSessionMarkerEvent(time: t1),
              ExerciseSessionMarkerEvent(time: t2),
            ],
          ),
          returnsNormally,
        );
      });

      test('accepts state transition events with different times', () {
        final t1 = startTime.add(const Duration(minutes: 5));
        final t2 = startTime.add(const Duration(minutes: 15));

        expect(
          () => ExerciseSessionRecord(
            startTime: startTime,
            endTime: endTime,
            exerciseType: exerciseType,
            metadata: metadata,
            events: [
              ExerciseSessionStateTransitionEvent(
                time: t1,
                type: ExerciseSessionStateTransitionType.pause,
              ),
              ExerciseSessionStateTransitionEvent(
                time: t2,
                type: ExerciseSessionStateTransitionType.resume,
              ),
            ],
          ),
          returnsNormally,
        );
      });
    });

    group('segment type compatibility', () {
      test(
        'accepts any segment type when session type is universal',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.bootCamp,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.yoga,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'accepts any segment type when '
        'session type is highIntensityIntervalTraining',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.highIntensityIntervalTraining,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.swimmingFreestyle,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'accepts universal segment types (e.g. pause) in any session type',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.yoga,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.pause,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'accepts session-specific allowed segment',
        () {
          final seg1Start = startTime.add(const Duration(minutes: 5));
          final seg1End = startTime.add(const Duration(minutes: 15));
          final seg2Start = startTime.add(const Duration(minutes: 20));
          final seg2End = startTime.add(const Duration(minutes: 30));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.running,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: seg1Start,
                  endTime: seg1End,
                  segmentType: ExerciseSegmentType.running,
                ),
                ExerciseSessionSegmentEvent(
                  startTime: seg2Start,
                  endTime: seg2End,
                  segmentType: ExerciseSegmentType.walking,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'accepts session-specific allowed segment (yoga for yoga session)',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.yoga,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.yoga,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );

      test(
        'throws ArgumentError when segment type is '
        'incompatible with session type',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.yoga,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.swimmingFreestyle,
                ),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'throws ArgumentError with message when segment type is incompatible',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.yoga,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.running,
                ),
              ],
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('not compatible'),
              ),
            ),
          );
        },
      );

      test(
        'throws ArgumentError when segment type is not compatible '
        'with session type',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.golf,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.rowingMachine,
                ),
              ],
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'accepts universal segment when session type has restricted segments',
        () {
          final segmentStart = startTime.add(const Duration(minutes: 5));
          final segmentEnd = startTime.add(const Duration(minutes: 15));

          expect(
            () => ExerciseSessionRecord(
              startTime: startTime,
              endTime: endTime,
              exerciseType: ExerciseType.golf,
              metadata: metadata,
              events: [
                ExerciseSessionSegmentEvent(
                  startTime: segmentStart,
                  endTime: segmentEnd,
                  segmentType: ExerciseSegmentType.pause,
                ),
              ],
            ),
            returnsNormally,
          );
        },
      );
    });
  });
}
