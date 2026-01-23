import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BodyMassIndexRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validBmi = Number(22.5);

    test('can be instantiated with valid parameters', () {
      final record = BodyMassIndexRecord(
        time: now,
        bmi: validBmi,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.bmi, equals(validBmi));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when bmi is below minBmi', () {
      expect(
        () => BodyMassIndexRecord(
          time: now,
          bmi: const Number(4.9),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when bmi is above maxBmi', () {
      expect(
        () => BodyMassIndexRecord(
          time: now,
          bmi: const Number(100.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BodyMassIndexRecord(
        time: now,
        bmi: validBmi,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newBmi = Number(25.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        bmi: newBmi,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.bmi, newBmi);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BodyMassIndexRecord(
        time: now,
        bmi: validBmi,
        metadata: metadata,
      );

      final record2 = BodyMassIndexRecord(
        time: now,
        bmi: validBmi,
        metadata: metadata,
      );

      final record3 = BodyMassIndexRecord(
        time: now,
        bmi: const Number(25.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
