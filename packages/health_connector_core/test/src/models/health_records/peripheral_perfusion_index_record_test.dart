import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PeripheralPerfusionIndexRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const percentage = Percentage.fromWhole(95);

    test('can be instantiated with valid parameters', () {
      final record = PeripheralPerfusionIndexRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.percentage, percentage);
      expect(record.metadata, metadata);
    });

    test('copyWith updates all fields correctly', () {
      final record = PeripheralPerfusionIndexRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPercentage = Percentage.fromWhole(98);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        percentage: newPercentage,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.percentage, newPercentage);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = PeripheralPerfusionIndexRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );
      final record2 = PeripheralPerfusionIndexRecord(
        time: now,
        percentage: percentage,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = PeripheralPerfusionIndexRecord(
        time: now,
        percentage: const Percentage.fromWhole(90),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
