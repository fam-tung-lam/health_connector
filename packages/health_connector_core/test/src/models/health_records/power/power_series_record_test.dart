import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PowerSeriesRecord', () {
    final startTime = DateTime.now().subtract(const Duration(hours: 1));
    final endTime = DateTime.now();
    final metadata = Metadata.manualEntry();
    final samples = [
      PowerSample(
        time: startTime,
        power: const Power.watts(100),
      ),
      PowerSample(
        time: startTime.add(const Duration(minutes: 30)),
        power: const Power.watts(200),
      ),
      PowerSample(
        time: endTime,
        power: const Power.watts(300),
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.metadata, metadata);
      expect(record.samples, samples);
    });

    test('calculates derived values correctly', () {
      final record = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      expect(record.minPower.inWatts, closeTo(100, 0.1));
      expect(record.maxPower.inWatts, closeTo(300, 0.1));
      expect(record.avgPower.inWatts, closeTo(200, 0.1));
    });

    test('throws ArgumentError when sample power is below minPower', () {
      expect(
        () => PowerSample(
          time: startTime,
          power: const Power.watts(-1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when sample power is above maxPower', () {
      expect(
        () => PowerSample(
          time: startTime,
          power: const Power.watts(3001),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      final newEndTime = endTime.add(const Duration(minutes: 10));
      final newMetadata = Metadata.manualEntry();
      final newSamples = [
        PowerSample(
          time: startTime,
          power: const Power.watts(400),
        ),
      ];

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
        samples: newSamples,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.endTime, newEndTime);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.samples, newSamples);
    });

    test('equality works correctly', () {
      final record1 = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: samples,
      );

      final record2 = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: [
          PowerSample(
            time: startTime,
            power: const Power.watts(100),
          ),
          PowerSample(
            time: startTime.add(const Duration(minutes: 30)),
            power: const Power.watts(200),
          ),
          PowerSample(
            time: endTime,
            power: const Power.watts(300),
          ),
        ],
      );

      final record3 = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: const [],
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    test('handles empty samples gracefully', () {
      final record = PowerSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        samples: const [],
      );

      expect(record.minPower, Power.zero);
      expect(record.maxPower, Power.zero);
      expect(record.avgPower, Power.zero);
    });
  });
}
