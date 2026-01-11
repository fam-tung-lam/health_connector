import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('MindfulnessSessionRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 15));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const sessionType = MindfulnessSessionType.meditation;
    const title = 'Morning Meditation';
    const notes = 'Focused on breath';

    test('can be instantiated with valid parameters', () {
      final record = MindfulnessSessionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        sessionType: sessionType,
        title: title,
        notes: notes,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.metadata, metadata);
      expect(record.sessionType, sessionType);
      expect(record.title, title);
      expect(record.notes, notes);
    });

    test('throws ArgumentError when startTime is after endTime', () {
      expect(
        () => MindfulnessSessionRecord(
          startTime: endTime,
          endTime: startTime,
          metadata: metadata,
          sessionType: sessionType,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = MindfulnessSessionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        sessionType: sessionType,
        title: title,
        notes: notes,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newType = MindfulnessSessionType.breathing;
      const newTitle = 'Breathing Exercise';
      const newNotes = 'Deep breaths';

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
        sessionType: newType,
        title: newTitle,
        notes: newNotes,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.endTime, newEndTime);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.sessionType, newType);
      expect(updatedRecord.title, newTitle);
      expect(updatedRecord.notes, newNotes);
    });

    test('equality works correctly', () {
      final record1 = MindfulnessSessionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        sessionType: sessionType,
        title: title,
        notes: notes,
      );

      final record2 = MindfulnessSessionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        sessionType: sessionType,
        title: title,
        notes: notes,
      );

      final record3 = MindfulnessSessionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        sessionType: MindfulnessSessionType.music,
        title: title,
        notes: notes,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
