import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SleepSessionRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 8));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    final samples = [
      SleepStageSample(
        startTime: startTime,
        endTime: startTime.add(const Duration(hours: 4)),
        stageType: SleepStage.light,
      ),
      SleepStageSample(
        startTime: startTime.add(const Duration(hours: 4)),
        endTime: endTime,
        stageType: SleepStage.deep,
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
        title: 'Night Sleep',
        notes: 'Good sleep',
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.samples, samples);
      expect(record.metadata, metadata);
      expect(record.title, 'Night Sleep');
      expect(record.notes, 'Good sleep');
    });

    test('throws ArgumentError when duration is below minDuration', () {
      final shortEndTime = startTime.add(const Duration(seconds: 30));
      expect(
        () => SleepSessionRecord(
          id: HealthRecordId.none,
          startTime: startTime,
          endTime: shortEndTime,
          samples: const [],
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when duration is above maxDuration', () {
      final longEndTime = startTime.add(const Duration(hours: 24, minutes: 1));
      expect(
        () => SleepSessionRecord(
          id: HealthRecordId.none,
          startTime: startTime,
          endTime: longEndTime,
          samples: const [],
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('totalSleepDuration calculates correctly', () {
      final record = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: [
          SleepStageSample(
            startTime: startTime,
            endTime: startTime.add(const Duration(hours: 2)),
            stageType: SleepStage.light,
          ),
          SleepStageSample(
            startTime: startTime.add(const Duration(hours: 2)),
            endTime: startTime.add(const Duration(hours: 3)),
            stageType: SleepStage.awake, // Should be excluded
          ),
          SleepStageSample(
            startTime: startTime.add(const Duration(hours: 3)),
            endTime: startTime.add(const Duration(hours: 5)),
            stageType: SleepStage.deep,
          ),
        ],
        metadata: metadata,
      );

      // 2h light + 2h deep = 4h
      expect(record.totalSleepDuration, const Duration(hours: 4));
    });

    test('copyWith updates all fields correctly', () {
      final record = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newTitle = 'Updated Title';
      const newNotes = 'Updated Notes';
      final newSamples = [samples.first];

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        samples: newSamples,
        title: newTitle,
        notes: newNotes,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.samples, newSamples);
      expect(updated.title, newTitle);
      expect(updated.notes, newNotes);
    });

    test('equality works correctly', () {
      final record1 = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      final record2 = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata, // same instance
      );

      // Deep copy of samples for record 2 to test deep equality?
      // actually samples list is same instance in this test.
      // Let's create new list with same content
      final samples2 = [
        SleepStageSample(
          startTime: startTime,
          endTime: startTime.add(const Duration(hours: 4)),
          stageType: SleepStage.light,
        ),
        SleepStageSample(
          startTime: startTime.add(const Duration(hours: 4)),
          endTime: endTime,
          stageType: SleepStage.deep,
        ),
      ];

      final record3 = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: samples2,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      // ListEquality should make record1 == record3 true as contents are same
      expect(record1 == record3, isTrue);

      final record4 = SleepSessionRecord(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        samples: const [],
        metadata: metadata,
      );

      expect(record1 == record4, isFalse);
    });
  });

  group('SleepStageSample', () {
    test('throws ArgumentError if endTime is before startTime', () {
      final now = DateTime(2026, 1, 11);
      expect(
        () => SleepStageSample(
          startTime: now,
          endTime: now.subtract(const Duration(minutes: 1)),
          stageType: SleepStage.light,
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final now = DateTime(2026, 1, 11);
      final end = now.add(const Duration(minutes: 30));
      final sample1 = SleepStageSample(
        startTime: now,
        endTime: end,
        stageType: SleepStage.light,
      );
      final sample2 = SleepStageSample(
        startTime: now,
        endTime: end,
        stageType: SleepStage.light,
      );
      final sample3 = SleepStageSample(
        startTime: now,
        endTime: end,
        stageType: SleepStage.deep,
      );

      expect(sample1 == sample2, isTrue);
      expect(sample1 == sample3, isFalse);
      expect(sample1.hashCode == sample2.hashCode, isTrue);
    });
  });
}
