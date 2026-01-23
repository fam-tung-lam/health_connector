import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('OxygenSaturationRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validSaturation = Percentage.fromWhole(98);

    test('can be instantiated with valid parameters', () {
      final record = OxygenSaturationRecord(
        time: now,
        saturation: validSaturation,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.saturation, validSaturation);
      expect(record.metadata, metadata);
    });

    // Validation Rationale:
    // Min at 0% (Percentage.zero) - hard to violate unless negative
    // Max at 100% (Percentage.full) - hard to violate unless > 1.0

    test('throws ArgumentError when saturation is below minSaturation', () {
      expect(
        () => OxygenSaturationRecord(
          time: now,
          saturation: const Percentage.fromWhole(-1.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when saturation is above maxSaturation', () {
      expect(
        () => OxygenSaturationRecord(
          time: now,
          saturation: const Percentage.fromWhole(101.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = OxygenSaturationRecord(
        time: now,
        saturation: validSaturation,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newSaturation = Percentage.fromWhole(95.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        saturation: newSaturation,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.saturation, newSaturation);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = OxygenSaturationRecord(
        time: now,
        saturation: validSaturation,
        metadata: metadata,
      );

      final record2 = OxygenSaturationRecord(
        time: now,
        saturation: validSaturation,
        metadata: metadata,
      );

      final record3 = OxygenSaturationRecord(
        time: now,
        saturation: const Percentage.fromWhole(99.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
