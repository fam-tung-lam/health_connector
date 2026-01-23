import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeartRateSeriesRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 10));
    final endTime = now;
    final metadata = Metadata.manualEntry();

    final samples = [
      HeartRateSample(
        time: startTime,
        rate: Frequency.perMinute(60),
      ),
      HeartRateSample(
        time: startTime.add(const Duration(minutes: 5)),
        rate: Frequency.perMinute(80),
      ),
      HeartRateSample(
        time: endTime,
        rate: Frequency.perMinute(100),
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.samples, samples);
      expect(record.metadata, metadata);
    });

    test('calculates correct derived values (avg, min, max)', () {
      final record = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      // Avg: (60 + 80 + 100) / 3 = 80
      expect(record.avgRate.inPerMinute, closeTo(80, 0.1));

      // Min: 60
      expect(record.minRate.inPerMinute, closeTo(60, 0.1));

      // Max: 100
      expect(record.maxRate.inPerMinute, closeTo(100, 0.1));
    });

    test('derived values handle empty samples', () {
      final record = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: const [],
        metadata: metadata,
      );

      expect(record.avgRate.inPerMinute, 0);
      expect(record.minRate.inPerMinute, 0);
      expect(record.maxRate.inPerMinute, 0);
    });

    test('derived values handle single sample', () {
      final record = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: [samples.first],
        metadata: metadata,
      );

      expect(record.avgRate.inPerMinute, closeTo(60, 0.1));
      expect(record.minRate.inPerMinute, closeTo(60, 0.1));
      expect(record.maxRate.inPerMinute, closeTo(60, 0.1));
    });

    test('copyWith updates fields correctly', () {
      final record = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      final newSamples = [samples.first];
      final updatedRecord = record.copyWith(
        samples: newSamples,
      );

      expect(updatedRecord.samples, newSamples);
      expect(updatedRecord.startTime, startTime.toUtc()); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      // Recreate samples list to ensure deep equality check
      final samples2 = [
        HeartRateSample(
          time: startTime,
          rate: Frequency.perMinute(60),
        ),
        HeartRateSample(
          time: startTime.add(const Duration(minutes: 5)),
          rate: Frequency.perMinute(80),
        ),
        HeartRateSample(
          time: endTime,
          rate: Frequency.perMinute(100),
        ),
      ];

      final record2 = HeartRateSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples2,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
