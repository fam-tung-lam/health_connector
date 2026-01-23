import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('NumberOfTimesFallenRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validCount = Number(5);

    test('can be instantiated with valid parameters', () {
      final record = NumberOfTimesFallenRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.count, equals(validCount));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when count is negative', () {
      expect(
        () => NumberOfTimesFallenRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(-1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when count is above maxCount', () {
      expect(
        () => NumberOfTimesFallenRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(101),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = NumberOfTimesFallenRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newCount = Number(10);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        count: newCount,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime.toUtc());
      expect(updatedRecord.count, newCount);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.endTime, endTime.toUtc()); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = NumberOfTimesFallenRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record2 = NumberOfTimesFallenRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record3 = NumberOfTimesFallenRecord(
        startTime: startTime,
        endTime: endTime,
        count: const Number(3),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
