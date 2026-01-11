import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WeightRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validWeight = Mass.kilograms(70.0);

    test('can be instantiated with valid parameters', () {
      final record = WeightRecord(
        time: now,
        weight: validWeight,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.weight, equals(validWeight));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when weight is below minWeight', () {
      expect(
        () => WeightRecord(
          time: now,
          weight: const Mass.kilograms(0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when weight is above maxWeight', () {
      expect(
        () => WeightRecord(
          time: now,
          weight: const Mass.kilograms(701.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = WeightRecord(
        time: now,
        weight: validWeight,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newWeight = Mass.kilograms(75.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        weight: newWeight,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.weight, newWeight);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = WeightRecord(
        time: now,
        weight: validWeight,
        metadata: metadata,
      );

      final record2 = WeightRecord(
        time: now,
        weight: validWeight,
        metadata: metadata,
      );

      final record3 = WeightRecord(
        time: now,
        weight: const Mass.kilograms(75.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
