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
  });
}
