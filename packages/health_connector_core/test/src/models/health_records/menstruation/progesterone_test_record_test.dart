import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ProgesteroneTestRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const result = ProgesteroneTestResult.positive;

    test('can be instantiated with valid parameters', () {
      final record = ProgesteroneTestRecord(
        time: now,
        result: result,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.result, result);
      expect(record.metadata, metadata);
    });

    test('copyWith updates all fields correctly', () {
      final record = ProgesteroneTestRecord(
        time: now,
        result: result,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newResult = ProgesteroneTestResult.negative;
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        result: newResult,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.result, newResult);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ProgesteroneTestRecord(
        time: now,
        result: result,
        metadata: metadata,
      );
      final record2 = ProgesteroneTestRecord(
        time: now,
        result: result,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = ProgesteroneTestRecord(
        time: now,
        result: ProgesteroneTestResult.negative,
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
