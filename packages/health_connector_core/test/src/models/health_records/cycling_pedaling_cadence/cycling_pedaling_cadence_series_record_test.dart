import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('CyclingPedalingCadenceSample', () {
    final now = DateTime(2026, 1, 11);
    final validCadence = Frequency.perMinute(90);

    test('can be instantiated with valid parameters', () {
      final sample = CyclingPedalingCadenceSample(
        time: now,
        cadence: validCadence,
      );

      expect(sample.time, now.toUtc());
      expect(sample.cadence, equals(validCadence));
    });

    test('throws ArgumentError when cadence is below minCadence', () {
      expect(
        () => CyclingPedalingCadenceSample(
          time: now,
          cadence: Frequency.perMinute(-1.0),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when cadence is above maxCadence', () {
      expect(
        () => CyclingPedalingCadenceSample(
          time: now,
          cadence: Frequency.perMinute(201.0),
        ),
        throwsArgumentError,
      );
    });
  });

  group('CyclingPedalingCadenceSeriesRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 10));
    final endTime = now;
    final metadata = Metadata.manualEntry();

    final samples = [
      CyclingPedalingCadenceSample(
        time: startTime,
        cadence: Frequency.perMinute(60.0),
      ),
      CyclingPedalingCadenceSample(
        time: startTime.add(const Duration(minutes: 5)),
        cadence: Frequency.perMinute(80.0),
      ),
      CyclingPedalingCadenceSample(
        time: endTime,
        cadence: Frequency.perMinute(100.0),
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      expect(record.samples, samples);
      expect(record.samplesCount, 3);
      expect(record.metadata, metadata);
    });

    test('avgCadence calculates correctly', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      // (60 + 80 + 100) / 3 = 80
      expect(record.avgCadence.inPerMinute, closeTo(80.0, 0.01));
    });

    test('avgCadence returns zero when samples is empty', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: const [],
      );

      expect(record.avgCadence, Frequency.zero);
    });

    test('minCadence calculates correctly', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      expect(record.minCadence.inPerMinute, closeTo(60.0, 0.01));
    });

    test('minCadence returns zero when samples is empty', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: const [],
      );

      expect(record.minCadence, Frequency.zero);
    });

    test('maxCadence calculates correctly', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      expect(record.maxCadence.inPerMinute, closeTo(100.0, 0.01));
    });

    test('maxCadence returns zero when samples is empty', () {
      final record = CyclingPedalingCadenceSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: const [],
      );

      expect(record.maxCadence, Frequency.zero);
    });
  });
}
