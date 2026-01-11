import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('MenstrualFlowRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 6));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const flow = MenstrualFlow.heavy;
    const isCycleStart = true;

    test('can be instantiated with valid parameters', () {
      final record = MenstrualFlowRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        flow: flow,
        isCycleStart: isCycleStart,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.metadata, metadata);
      expect(record.flow, flow);
      expect(record.isCycleStart, isCycleStart);
    });

    test('copyWith updates fields correctly', () {
      final record = MenstrualFlowRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        flow: flow,
        isCycleStart: isCycleStart,
      );

      final newTime = startTime.subtract(const Duration(hours: 1));
      const newFlow = MenstrualFlow.medium;

      final updatedRecord = record.copyWith(
        startTime: newTime,
        flow: newFlow,
      );

      expect(updatedRecord.startTime, newTime);
      expect(updatedRecord.flow, newFlow);
      expect(updatedRecord.isCycleStart, isCycleStart); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = MenstrualFlowRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        flow: flow,
        isCycleStart: isCycleStart,
      );

      final record2 = MenstrualFlowRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        flow: flow,
        isCycleStart: isCycleStart,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
