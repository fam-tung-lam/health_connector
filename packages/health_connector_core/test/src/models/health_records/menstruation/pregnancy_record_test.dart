import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PregnancyRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(days: 280)); // 9 months approx
    final metadata = Metadata.manualEntry();

    test('can be instantiated with valid parameters', () {
      final record = PregnancyRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record.startTime, now);
      expect(record.endTime, endTime);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => PregnancyRecord(
          startTime: endTime,
          endTime: now,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = PregnancyRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(days: 1));
      final newEndTime = endTime.add(const Duration(days: 1));
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = PregnancyRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );
      final record2 = PregnancyRecord(
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = PregnancyRecord(
        startTime: now,
        endTime: endTime.add(const Duration(days: 1)),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
