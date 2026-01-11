import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('OvulationTestRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const result = OvulationTestResult.positive;

    test('can be instantiated with valid parameters', () {
      final record = OvulationTestRecord(
        time: now,
        metadata: metadata,
        result: result,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.result, result);
    });

    test('copyWith updates fields correctly', () {
      final record = OvulationTestRecord(
        time: now,
        metadata: metadata,
        result: result,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      const newResult = OvulationTestResult.negative;

      final updatedRecord = record.copyWith(
        time: newTime,
        result: newResult,
      );

      expect(updatedRecord.time, newTime);
      expect(updatedRecord.result, newResult);
      expect(updatedRecord.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = OvulationTestRecord(
        time: now,
        metadata: metadata,
        result: result,
      );

      final record2 = OvulationTestRecord(
        time: now,
        metadata: metadata,
        result: result,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
