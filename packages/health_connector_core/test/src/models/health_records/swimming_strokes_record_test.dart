import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group('SwimmingStrokesRecord', () {
    test('instantiates with valid parameters', () {
      final startTime = DateTime(2023, 10, 26, 8, 30);
      final endTime = startTime.add(const Duration(minutes: 30));
      const count = Number(500);
      final metadata = Metadata.manualEntry();

      final record = SwimmingStrokesRecord(
        startTime: startTime,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.count, count);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError if count is negative', () {
      final startTime = DateTime(2023, 10, 26, 8, 30);
      final endTime = startTime.add(const Duration(minutes: 30));

      expect(
        () => SwimmingStrokesRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(-10),
          metadata: Metadata.manualEntry(),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError if count is too large', () {
      final startTime = DateTime(2023, 10, 26, 8, 30);
      final endTime = startTime.add(const Duration(minutes: 30));

      expect(
        () => SwimmingStrokesRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(100001),
          metadata: Metadata.manualEntry(),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError if endTime is before startTime', () {
      final startTime = DateTime(2023, 10, 26, 8, 30);
      final endTime = startTime.subtract(const Duration(minutes: 5));

      expect(
        () => SwimmingStrokesRecord(
          startTime: startTime,
          endTime: endTime,
          count: const Number(100),
          metadata: Metadata.manualEntry(),
        ),
        throwsArgumentError,
      );
    });

    test('validates equality correctly', () {
      final startTime = DateTime(2023, 10, 26, 12);
      final endTime = startTime.add(const Duration(minutes: 30));
      const count = Number(500);
      final metadata = Metadata.manualEntry();

      final record1 = SwimmingStrokesRecord(
        startTime: startTime,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      final record2 = SwimmingStrokesRecord(
        startTime: startTime,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      final record3 = SwimmingStrokesRecord(
        startTime: startTime,
        endTime: endTime,
        count: const Number(600),
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });

    test('copyWith creates a new instance with updated values', () {
      final startTime = DateTime(2023, 10, 26, 8, 30);
      final endTime = startTime.add(const Duration(minutes: 30));
      final record = SwimmingStrokesRecord(
        startTime: startTime,
        endTime: endTime,
        count: const Number(500),
        metadata: Metadata.manualEntry(),
      );

      const newCount = Number(600);
      final updatedRecord = record.copyWith(count: newCount);

      expect(updatedRecord.count, newCount);
      expect(updatedRecord.startTime, startTime.toUtc());
      expect(updatedRecord.endTime, endTime.toUtc());
      expect(updatedRecord.metadata, record.metadata);
    });
  });
}
