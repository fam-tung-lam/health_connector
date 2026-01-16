import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BloodAlcoholContentRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const percentage = Percentage.fromWhole(0.08);

    test('can be instantiated with valid parameters', () {
      final record = BloodAlcoholContentRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.percentage, percentage);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when percentage is invalid', () {
      expect(
        () => BloodAlcoholContentRecord(
          time: now,
          percentage: const Percentage.fromWhole(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BloodAlcoholContentRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPercentage = Percentage.fromWhole(0.12);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        percentage: newPercentage,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.percentage, newPercentage);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BloodAlcoholContentRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );
      final record2 = BloodAlcoholContentRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = BloodAlcoholContentRecord(
        time: now,
        percentage: const Percentage.fromWhole(0.05),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
