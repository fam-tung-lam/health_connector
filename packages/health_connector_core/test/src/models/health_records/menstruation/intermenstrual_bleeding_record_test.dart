import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('IntermenstrualBleedingRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();

    test('can be instantiated with valid parameters', () {
      final record = IntermenstrualBleedingRecord(
        time: now,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
    });

    test('copyWith updates all fields correctly', () {
      final record = IntermenstrualBleedingRecord(
        time: now,
        metadata: metadata,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        time: newTime,
        metadata: newMetadata,
      );

      expect(updatedRecord.time, newTime.toUtc());
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = IntermenstrualBleedingRecord(
        time: now,
        metadata: metadata,
      );

      final record2 = IntermenstrualBleedingRecord(
        time: now,
        metadata: metadata,
      );

      // Mutate time slightly for inequality
      final record3 = IntermenstrualBleedingRecord(
        time: now.add(const Duration(seconds: 1)),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
