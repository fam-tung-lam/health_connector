import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  final start = DateTime(2026, 3, 28);
  final end = DateTime(2026, 3, 31);

  test(
    'GIVEN complete local days WHEN validated THEN accepts '
    'local and UTC instants',
    () {
      // Given / When / Then
      for (final range in [(start, end), (start.toUtc(), end.toUtc())]) {
        expect(
          () => validateDailyAggregateRequest(
            HealthDataType.hydration.aggregateSum(
              startTime: range.$1,
              endTime: range.$2,
            ),
          ),
          returnsNormally,
        );
      }
    },
  );

  test(
    'GIVEN partial start or end WHEN validated THEN rejects either boundary',
    () {
      // Given / When / Then
      for (final range in [
        (start.add(const Duration(microseconds: 1)), end),
        (start, end.add(const Duration(hours: 1))),
      ]) {
        expect(
          () => validateDailyAggregateRequest(
            HealthDataType.hydration.aggregateSum(
              startTime: range.$1,
              endTime: range.$2,
            ),
          ),
          throwsArgumentError,
        );
      }
    },
  );

  test(
    'GIVEN native metrics WHEN validated THEN accepts all request variants',
    () {
      // Given
      final requests = <AggregateRequest<MeasurementUnit>>[
        HealthDataType.steps.aggregateSum(startTime: start, endTime: end),
        HealthDataType.weight.aggregateMin(startTime: start, endTime: end),
        HealthDataType.weight.aggregateAvg(startTime: start, endTime: end),
        HealthDataType.weight.aggregateMax(startTime: start, endTime: end),
        HealthDataType.bloodPressure.aggregateAverage(
          bloodPressureType: HealthDataType.systolicBloodPressure,
          startTime: start,
          endTime: end,
        ),
        HealthDataType.activityIntensity.aggregateSum(
          startTime: start,
          endTime: end,
        ),
      ];
      // When / Then
      for (final request in requests) {
        expect(() => validateDailyAggregateRequest(request), returnsNormally);
      }
    },
  );

  test(
    'GIVEN saved workout request WHEN validated THEN rejects '
    'specialized aggregation',
    () {
      // Given
      final request = ExerciseSessionActiveEnergyAggregateRequest(
        exerciseSessionId: HealthRecordId('saved-workout'),
        startTime: start,
        endTime: end,
      );
      // When / Then
      expect(
        () => validateDailyAggregateRequest(request),
        throwsA(isA<UnsupportedOperationException>()),
      );
    },
  );
}
