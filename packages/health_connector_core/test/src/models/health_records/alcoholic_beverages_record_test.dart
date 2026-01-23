import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('AlcoholicBeveragesRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(minutes: 30));
    final metadata = Metadata.manualEntry();
    const count = Number(2);

    test('can be instantiated with valid parameters', () {
      final record = AlcoholicBeveragesRecord(
        startTime: now,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.count, count);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when count is negative', () {
      expect(
        () => AlcoholicBeveragesRecord(
          startTime: now,
          endTime: endTime,
          count: const Number(-1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => AlcoholicBeveragesRecord(
          startTime: endTime,
          endTime: now,
          count: count,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = AlcoholicBeveragesRecord(
        startTime: now,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newCount = Number(3);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        count: newCount,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.count, newCount);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = AlcoholicBeveragesRecord(
        startTime: now,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );
      final record2 = AlcoholicBeveragesRecord(
        startTime: now,
        endTime: endTime,
        count: count,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = AlcoholicBeveragesRecord(
        startTime: now,
        endTime: endTime,
        count: const Number(5),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
