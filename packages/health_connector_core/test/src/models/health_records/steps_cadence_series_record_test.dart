import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('StepsCadenceSeriesRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(minutes: 10));
    final metadata = Metadata.manualEntry();
    final sample1 = StepsCadenceSample(
      time: now,
      cadence: Frequency.perMinute(120),
    );
    final sample2 = StepsCadenceSample(
      time: now.add(const Duration(minutes: 5)),
      cadence: Frequency.perMinute(130),
    );
    final validSamples = [sample1, sample2];

    test('can be instantiated with valid parameters', () {
      final record = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      expect(record.startTime, now);
      expect(record.endTime, endTime);
      expect(record.samples, validSamples);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when sample cadence is below minCadence', () {
      expect(
        () => StepsCadenceSample(
          time: now,
          cadence: Frequency.perMinute(-1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when sample cadence is above maxCadence', () {
      expect(
        () => StepsCadenceSample(
          time: now,
          cadence: Frequency.perMinute(10001),
        ),
        throwsArgumentError,
      );
    });

    test('avgCadence calculates correctly', () {
      final record = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      // (120 + 130) / 2 = 125
      expect(record.avgCadence, equals(Frequency.perMinute(125)));
    });

    test('minCadence calculates correctly', () {
      final record = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      expect(record.minCadence, equals(Frequency.perMinute(120)));
    });

    test('maxCadence calculates correctly', () {
      final record = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      expect(record.maxCadence, equals(Frequency.perMinute(130)));
    });

    test('copyWith updates all fields correctly', () {
      final record = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      final newSamples = [sample1];

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
        samples: newSamples,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.metadata, newMetadata);
      expect(updated.samples, newSamples);
    });

    test('equality works correctly', () {
      final record1 = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );
      final record2 = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: validSamples,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = StepsCadenceSeriesRecord(
        startTime: now,
        endTime: endTime,
        samples: [sample1],
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
