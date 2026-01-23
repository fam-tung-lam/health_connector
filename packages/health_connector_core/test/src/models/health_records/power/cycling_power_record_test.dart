import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('CyclingPowerRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validPower = Power.watts(200);

    test('can be instantiated with valid parameters', () {
      final record = CyclingPowerRecord(
        time: now,
        metadata: metadata,
        power: validPower,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.power, equals(validPower));
    });

    test('throws ArgumentError when power is below minPower', () {
      expect(
        () => CyclingPowerRecord(
          time: now,
          metadata: metadata,
          power: const Power.watts(-1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when power is above maxPower', () {
      expect(
        () => CyclingPowerRecord(
          time: now,
          metadata: metadata,
          power: const Power.watts(3001),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = CyclingPowerRecord(
        time: now,
        metadata: metadata,
        power: validPower,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPower = Power.watts(250);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        time: newTime,
        power: newPower,
        metadata: newMetadata,
      );

      expect(updatedRecord.time, newTime.toUtc());
      expect(updatedRecord.power, newPower);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = CyclingPowerRecord(
        time: now,
        metadata: metadata,
        power: validPower,
      );

      final record2 = CyclingPowerRecord(
        time: now,
        metadata: metadata,
        power: validPower,
      );

      final record3 = CyclingPowerRecord(
        time: now,
        metadata: metadata,
        power: const Power.watts(150),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
