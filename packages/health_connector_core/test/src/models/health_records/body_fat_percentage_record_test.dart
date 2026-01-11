import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BodyFatPercentageRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validPercentage = Percentage.fromWhole(20.0);

    test('can be instantiated with valid parameters', () {
      final record = BodyFatPercentageRecord(
        time: now,
        percentage: validPercentage,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.percentage, validPercentage);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when percentage is below minPercentage', () {
      expect(
        () => BodyFatPercentageRecord(
          time: now,
          percentage: const Percentage.fromWhole(1.9),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when percentage is above maxPercentage', () {
      expect(
        () => BodyFatPercentageRecord(
          time: now,
          percentage: const Percentage.fromWhole(65.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BodyFatPercentageRecord(
        time: now,
        percentage: validPercentage,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPercentage = Percentage.fromWhole(22.0);
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
      final record1 = BodyFatPercentageRecord(
        time: now,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record2 = BodyFatPercentageRecord(
        time: now,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record3 = BodyFatPercentageRecord(
        time: now,
        percentage: const Percentage.fromWhole(21.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
