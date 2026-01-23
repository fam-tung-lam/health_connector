import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RunningPowerRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validPower = Power.watts(250.0);

    test('can be instantiated with valid parameters', () {
      final record = RunningPowerRecord(
        time: now,
        power: validPower,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.power, validPower);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when power is below minPower', () {
      expect(
        () => RunningPowerRecord(
          time: now,
          power: const Power.watts(-1.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when power is above maxPower', () {
      expect(
        () => RunningPowerRecord(
          time: now,
          power: const Power.watts(4001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = RunningPowerRecord(
        time: now,
        power: validPower,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPower = Power.watts(300.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        power: newPower,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.power, newPower);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = RunningPowerRecord(
        time: now,
        power: validPower,
        metadata: metadata,
      );
      final record2 = RunningPowerRecord(
        time: now,
        power: validPower,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = RunningPowerRecord(
        time: now,
        power: const Power.watts(300.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
