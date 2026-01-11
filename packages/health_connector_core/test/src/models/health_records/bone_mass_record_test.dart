import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BoneMassRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validMass = Mass.kilograms(3.0);

    test('can be instantiated with valid parameters', () {
      final record = BoneMassRecord(
        time: now,
        mass: validMass,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.mass, validMass);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => BoneMassRecord(
          time: now,
          mass: const Mass.kilograms(0.05),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => BoneMassRecord(
          time: now,
          mass: const Mass.kilograms(15.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BoneMassRecord(
        time: now,
        mass: validMass,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newMass = Mass.kilograms(3.5);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        mass: newMass,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.mass, newMass);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BoneMassRecord(
        time: now,
        mass: validMass,
        metadata: metadata,
      );

      final record2 = BoneMassRecord(
        time: now,
        mass: validMass,
        metadata: metadata,
      );

      final record3 = BoneMassRecord(
        time: now,
        mass: const Mass.kilograms(3.1),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
