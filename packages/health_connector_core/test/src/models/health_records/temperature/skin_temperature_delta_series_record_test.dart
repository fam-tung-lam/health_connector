import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SkinTemperatureDeltaSeriesRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 10));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const baseline = Temperature.celsius(36.5);

    final samples = [
      SkinTemperatureDeltaSample(
        time: startTime,
        temperatureDelta: const Temperature.celsius(0.2),
      ),
      SkinTemperatureDeltaSample(
        time: startTime.add(const Duration(minutes: 5)),
        temperatureDelta: const Temperature.celsius(-0.1),
      ),
      SkinTemperatureDeltaSample(
        time: endTime.subtract(const Duration(seconds: 1)),
        temperatureDelta: const Temperature.celsius(0.3),
      ),
    ];

    test('can be instantiated with valid parameters', () {
      final record = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: baseline,
        measurementLocation: SkinTemperatureMeasurementLocation.wrist,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.samples, samples);
      expect(record.baseline, baseline);
      expect(
        record.measurementLocation,
        SkinTemperatureMeasurementLocation.wrist,
      );
      expect(record.metadata, metadata);
    });

    test('can be instantiated without baseline', () {
      final record = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        metadata: metadata,
      );

      expect(record.baseline, isNull);
    });

    test('can be instantiated with minimum baseline', () {
      final record = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: SkinTemperatureDeltaSeriesRecord.minBaseline,
        metadata: metadata,
      );

      expect(record.baseline, SkinTemperatureDeltaSeriesRecord.minBaseline);
    });

    test('can be instantiated with maximum baseline', () {
      final record = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: SkinTemperatureDeltaSeriesRecord.maxBaseline,
        metadata: metadata,
      );

      expect(record.baseline, SkinTemperatureDeltaSeriesRecord.maxBaseline);
    });

    test('throws ArgumentError when baseline is below minBaseline', () {
      expect(
        () => SkinTemperatureDeltaSeriesRecord(
          startTime: startTime,
          endTime: endTime,
          samples: samples,
          baseline: const Temperature.celsius(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when baseline is above maxBaseline', () {
      expect(
        () => SkinTemperatureDeltaSeriesRecord(
          startTime: startTime,
          endTime: endTime,
          samples: samples,
          baseline: const Temperature.celsius(100.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => SkinTemperatureDeltaSeriesRecord(
          startTime: endTime,
          endTime: startTime,
          samples: samples,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when sample time is before startTime', () {
      final invalidSamples = [
        SkinTemperatureDeltaSample(
          time: startTime.subtract(const Duration(seconds: 1)),
          temperatureDelta: const Temperature.celsius(0.2),
        ),
      ];

      expect(
        () => SkinTemperatureDeltaSeriesRecord(
          startTime: startTime,
          endTime: endTime,
          samples: invalidSamples,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when sample time is at or after endTime', () {
      final invalidSamples = [
        SkinTemperatureDeltaSample(
          time: endTime,
          temperatureDelta: const Temperature.celsius(0.2),
        ),
      ];

      expect(
        () => SkinTemperatureDeltaSeriesRecord(
          startTime: startTime,
          endTime: endTime,
          samples: invalidSamples,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: baseline,
        measurementLocation: SkinTemperatureMeasurementLocation.wrist,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newBaseline = Temperature.celsius(37.0);
      const newLocation = SkinTemperatureMeasurementLocation.finger;
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        baseline: newBaseline,
        measurementLocation: newLocation,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.baseline, newBaseline);
      expect(updated.measurementLocation, newLocation);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: baseline,
        measurementLocation: SkinTemperatureMeasurementLocation.wrist,
        metadata: metadata,
      );

      final record2 = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: baseline,
        measurementLocation: SkinTemperatureMeasurementLocation.wrist,
        metadata: metadata,
      );

      final record3 = SkinTemperatureDeltaSeriesRecord(
        startTime: startTime,
        endTime: endTime,
        samples: samples,
        baseline: const Temperature.celsius(37.0),
        measurementLocation: SkinTemperatureMeasurementLocation.wrist,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });

  group('SkinTemperatureDeltaSample', () {
    final now = DateTime(2026, 1, 11).toUtc();
    const validDelta = Temperature.celsius(0.5);

    test('can be instantiated with valid parameters', () {
      final sample = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: validDelta,
      );

      expect(sample.time, now);
      expect(sample.temperatureDelta, equals(validDelta));
    });

    test('can be instantiated with minimum delta', () {
      final sample = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: SkinTemperatureDeltaSample.minDelta,
      );

      expect(sample.temperatureDelta, SkinTemperatureDeltaSample.minDelta);
    });

    test('can be instantiated with maximum delta', () {
      final sample = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: SkinTemperatureDeltaSample.maxDelta,
      );

      expect(sample.temperatureDelta, SkinTemperatureDeltaSample.maxDelta);
    });

    test('throws ArgumentError when delta is below minDelta', () {
      expect(
        () => SkinTemperatureDeltaSample(
          time: now,
          temperatureDelta: const Temperature.celsius(-30.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when delta is above maxDelta', () {
      expect(
        () => SkinTemperatureDeltaSample(
          time: now,
          temperatureDelta: const Temperature.celsius(30.1),
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final sample1 = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: validDelta,
      );

      final sample2 = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: validDelta,
      );

      final sample3 = SkinTemperatureDeltaSample(
        time: now,
        temperatureDelta: const Temperature.celsius(1.0),
      );

      expect(sample1 == sample2, isTrue);
      expect(sample1 == sample3, isFalse);
      expect(sample1.hashCode == sample2.hashCode, isTrue);
    });
  });
}
