import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('LactationRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(minutes: 10));
    final metadata = Metadata.manualEntry();

    test('can be instantiated with valid parameters', () {
      final record = LactationRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => LactationRecord(
          startTime: endTime,
          endTime: now,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = LactationRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = LactationRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );
      final record2 = LactationRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = LactationRecord(
        startTime: now,
        endTime: endTime.add(const Duration(minutes: 1)),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
