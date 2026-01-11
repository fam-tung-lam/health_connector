import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SpeedSeriesRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    final samples = [
      SpeedSample(
        time: startTime,
        speed: const Velocity.kilometersPerHour(5.0),
      ),
      SpeedSample(
        time: endTime,
        speed: const Velocity.kilometersPerHour(6.0),
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.samples, samples);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => SpeedSeriesRecord(
          startTime: endTime,
          endTime: startTime,
          samples: const [],
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('calculates statistics correctly', () {
      final record = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      // 5.0 and 6.0 avg = 5.5
      expect(record.avgSpeed.inKilometersPerHour, closeTo(5.5, 0.001));
      expect(record.maxSpeed.inKilometersPerHour, 6.0);
      expect(record.minSpeed.inKilometersPerHour, 5.0);
    });

    test('calculates statistics correctly with empty samples', () {
      final record = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: const [],
        metadata: metadata,
      );

      expect(record.avgSpeed, Velocity.zero);
      expect(record.maxSpeed, Velocity.zero);
      expect(record.minSpeed, Velocity.zero);
    });

    test('copyWith updates all fields correctly', () {
      final record = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      final newSamples = [samples.first];
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        samples: newSamples,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.samples, newSamples);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      final record2 = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      // Different samples
      final samples2 = [samples.first];
      final record3 = SpeedSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples2,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      // Samples contain identical objects in same order
      expect(record1.samples.first == record2.samples.first, isTrue);
      expect(record1 == record3, isFalse);
    });
  });

  group('SpeedSample', () {
    test('throws ArgumentError when speed is invalid', () {
      expect(
        () => SpeedSample(
          time: DateTime.now(),
          speed: const Velocity.kilometersPerHour(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final now = DateTime(2026, 1, 11);
      final sample1 = SpeedSample(
        time: now,
        speed: const Velocity.kilometersPerHour(5.0),
      );
      final sample2 = SpeedSample(
        time: now,
        speed: const Velocity.kilometersPerHour(5.0),
      );
      final sample3 = SpeedSample(
        time: now,
        speed: const Velocity.kilometersPerHour(6.0),
      );

      expect(sample1 == sample2, isTrue);
      expect(sample1 == sample3, isFalse);
      expect(sample1.hashCode == sample2.hashCode, isTrue);
    });
  });
}
