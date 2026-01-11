import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SleepStageRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const stageType = SleepStage.light;

    test('can be instantiated with valid parameters', () {
      final record = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: stageType,
        metadata: metadata,
        title: 'Nap',
        notes: 'Good',
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.stageType, stageType);
      expect(record.metadata, metadata);
      expect(record.title, 'Nap');
      expect(record.notes, 'Good');
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => SleepStageRecord(
          id: HealthRecordId.none,
          startTime: endTime,
          endTime: startTime,
          stageType: stageType,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('isActualSleep returns correct values', () {
      var record = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: SleepStage.light,
        metadata: metadata,
      );
      expect(record.isActualSleep, isTrue);

      record = record.copyWith(stageType: SleepStage.awake);
      expect(record.isActualSleep, isFalse);

      record = record.copyWith(stageType: SleepStage.inBed);
      expect(record.isActualSleep, isFalse);

      record = record.copyWith(stageType: SleepStage.deep);
      expect(record.isActualSleep, isTrue);
    });

    test('copyWith updates all fields correctly', () {
      final record = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: stageType,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newStageType = SleepStage.deep;
      const newTitle = 'Updated';
      const newNotes = 'Notes';
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        stageType: newStageType,
        title: newTitle,
        notes: newNotes,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.stageType, newStageType);
      expect(updated.title, newTitle);
      expect(updated.notes, newNotes);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: stageType,
        metadata: metadata,
      );

      final record2 = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: stageType,
        metadata: metadata,
      );

      final record3 = SleepStageRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        stageType: SleepStage.deep,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
