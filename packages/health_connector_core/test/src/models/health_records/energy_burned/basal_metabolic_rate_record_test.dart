import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BasalMetabolicRateRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validRate = Power.kilocaloriesPerDay(1800.0);

    test('can be instantiated with valid parameters', () {
      final record = BasalMetabolicRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.rate, equals(validRate));
      expect(record.metadata, metadata);
    });

    test('can be instantiated with minimum rate', () {
      final record = BasalMetabolicRateRecord(
        time: now,
        rate: BasalMetabolicRateRecord.minRate,
        metadata: metadata,
      );

      expect(record.rate, BasalMetabolicRateRecord.minRate);
    });

    test('can be instantiated with maximum rate', () {
      final record = BasalMetabolicRateRecord(
        time: now,
        rate: BasalMetabolicRateRecord.maxRate,
        metadata: metadata,
      );

      expect(record.rate, BasalMetabolicRateRecord.maxRate);
    });

    test('throws ArgumentError when rate is below minRate', () {
      expect(
        () => BasalMetabolicRateRecord(
          time: now,
          rate: const Power.kilocaloriesPerDay(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when rate is above maxRate', () {
      expect(
        () => BasalMetabolicRateRecord(
          time: now,
          rate: const Power.kilocaloriesPerDay(10000.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BasalMetabolicRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newRate = Power.kilocaloriesPerDay(1900.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        rate: newRate,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.rate, newRate);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BasalMetabolicRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final record2 = BasalMetabolicRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final record3 = BasalMetabolicRateRecord(
        time: now,
        rate: const Power.kilocaloriesPerDay(1900.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
