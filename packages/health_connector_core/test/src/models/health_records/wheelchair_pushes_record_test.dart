import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WheelchairPushesRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validCount = Number(500);

    test('can be instantiated with valid parameters', () {
      final record = WheelchairPushesRecord(
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
        () => WheelchairPushesRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(-1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = WheelchairPushesRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newCount = Number(600);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        count: newCount,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.count, newCount);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.endTime, endTime); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = WheelchairPushesRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record2 = WheelchairPushesRecord(
        startTime: startTime,
        endTime: endTime,
        count: validCount,
        metadata: metadata,
      );

      final record3 = WheelchairPushesRecord(
        startTime: startTime,
        endTime: endTime,
        count: const Number(600),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
