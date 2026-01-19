import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ExerciseTimeRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validDuration = TimeDuration.minutes(30);

    test('equality works correctly', () {
      final record1 = ExerciseTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        exerciseTime: validDuration,
        metadata: metadata,
      );

      final record2 = ExerciseTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        exerciseTime: validDuration,
        metadata: metadata,
      );

      final record3 = ExerciseTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        exerciseTime: const TimeDuration.minutes(15),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
