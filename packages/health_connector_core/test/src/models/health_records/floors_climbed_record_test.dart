import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('FloorsClimbedRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validCount = Number(5);

    test('can be instantiated with valid parameters', () {
      final record = FloorsClimbedRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.count, equals(validCount));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when count is negative', () {
      expect(
        () => FloorsClimbedRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(-1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when count is above maxFloors', () {
      expect(
        () => FloorsClimbedRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(1001),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = FloorsClimbedRecord(
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

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.count, newCount);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.endTime, endTime);
    });

    test('equality works correctly', () {
      final record1 = FloorsClimbedRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record2 = FloorsClimbedRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record3 = FloorsClimbedRecord(
        startTime: startTime,
        endTime: endTime,
        count: const Number(10),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
