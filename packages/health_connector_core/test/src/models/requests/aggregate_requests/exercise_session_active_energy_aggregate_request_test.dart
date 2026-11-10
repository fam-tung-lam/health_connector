import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  ExerciseSessionRecord exerciseSessionWithId(HealthRecordId id) =>
      ExerciseSessionRecord(
        id: id,
        startTime: FakeData.fakeStartTime,
        endTime: FakeData.fakeEndTime,
        exerciseType: ExerciseType.running,
        metadata: Metadata.manualEntry(),
      );

  group('ExerciseSessionActiveEnergyAggregateRequest', () {
    test('saved exercise session creates an active energy sum request', () {
      // Given
      final exerciseSession = exerciseSessionWithId(
        HealthRecordId(FakeData.fakeId),
      );

      // When
      final request = HealthDataType.exerciseSession
          .aggregateActiveEnergyBurnedFor(exerciseSession: exerciseSession);

      // Then
      expect(request, isA<AggregateRequest<Energy>>());
      expect(request.dataType, HealthDataType.activeEnergyBurned);
      expect(request.aggregationMetric, AggregationMetric.sum);
      expect(request.startTime, FakeData.fakeStartTime);
      expect(request.endTime, FakeData.fakeEndTime);
      expect(
        (request as ExerciseSessionActiveEnergyAggregateRequest)
            .exerciseSessionId,
        exerciseSession.id,
      );
    });

    test(
      'saved workout with zero duration preserves its ID and timestamps',
      () {
        // Given
        final exerciseSession = ExerciseSessionRecord.internal(
          id: HealthRecordId(FakeData.fakeId),
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeStartTime,
          exerciseType: ExerciseType.running,
          metadata: Metadata.manualEntry(),
        );

        // When
        final request = HealthDataType.exerciseSession
            .aggregateActiveEnergyBurnedFor(exerciseSession: exerciseSession);

        // Then
        expect(request.startTime, FakeData.fakeStartTime);
        expect(request.endTime, FakeData.fakeStartTime);
        expect(
          (request as ExerciseSessionActiveEnergyAggregateRequest)
              .exerciseSessionId,
          exerciseSession.id,
        );
      },
    );

    test('saved workout with negative duration is rejected', () {
      // Given
      final exerciseSession = ExerciseSessionRecord.internal(
        id: HealthRecordId(FakeData.fakeId),
        startTime: FakeData.fakeEndTime,
        endTime: FakeData.fakeStartTime,
        exerciseType: ExerciseType.running,
        metadata: Metadata.manualEntry(),
      );

      // When / Then
      expect(
        () => HealthDataType.exerciseSession.aggregateActiveEnergyBurnedFor(
          exerciseSession: exerciseSession,
        ),
        throwsA(
          isA<ArgumentError>().having((error) => error.name, 'name', 'endTime'),
        ),
      );
    });

    test('workout with zero duration still requires a saved ID', () {
      // Given
      final exerciseSession = ExerciseSessionRecord.internal(
        id: HealthRecordId.none,
        startTime: FakeData.fakeStartTime,
        endTime: FakeData.fakeStartTime,
        exerciseType: ExerciseType.running,
        metadata: Metadata.manualEntry(),
      );

      // When / Then
      expect(
        () => HealthDataType.exerciseSession.aggregateActiveEnergyBurnedFor(
          exerciseSession: exerciseSession,
        ),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.name,
            'name',
            'exerciseSessionId',
          ),
        ),
      );
    });

    test('unsaved exercise session rejects active energy aggregation', () {
      // Given
      final exerciseSession = exerciseSessionWithId(HealthRecordId.none);

      // When / Then
      expect(
        () => HealthDataType.exerciseSession.aggregateActiveEnergyBurnedFor(
          exerciseSession: exerciseSession,
        ),
        throwsArgumentError,
      );
    });

    test('requests distinguish exercise sessions with the same time range', () {
      // Given
      final exerciseSession = exerciseSessionWithId(
        HealthRecordId(FakeData.fakeId),
      );
      final otherExerciseSession = exerciseSessionWithId(
        HealthRecordId('other-exercise-session'),
      );

      // When
      final request = HealthDataType.exerciseSession
          .aggregateActiveEnergyBurnedFor(exerciseSession: exerciseSession);
      final equalRequest = HealthDataType.exerciseSession
          .aggregateActiveEnergyBurnedFor(exerciseSession: exerciseSession);
      final otherRequest = HealthDataType.exerciseSession
          .aggregateActiveEnergyBurnedFor(
            exerciseSession: otherExerciseSession,
          );

      // Then
      expect(request, equalRequest);
      expect(request.hashCode, equalRequest.hashCode);
      expect(request, isNot(otherRequest));
    });

    test(
      'request description omits the exercise session ID and timestamps',
      () {
        // Given
        final request = HealthDataType.exerciseSession
            .aggregateActiveEnergyBurnedFor(
              exerciseSession: exerciseSessionWithId(
                HealthRecordId(FakeData.fakeId),
              ),
            );

        // When
        final description = request.toString();

        // Then
        expect(description, isNot(contains(FakeData.fakeId)));
        expect(description, isNot(contains(FakeData.fakeStartTime.toString())));
        expect(description, isNot(contains(FakeData.fakeEndTime.toString())));
      },
    );
  });
}
