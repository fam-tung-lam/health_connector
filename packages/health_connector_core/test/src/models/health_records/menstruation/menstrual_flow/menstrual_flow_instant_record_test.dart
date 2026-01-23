import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('MenstrualFlowInstantRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const flow = MenstrualFlow.heavy;

    test('can be instantiated with valid parameters', () {
      final record = MenstrualFlowInstantRecord(
        time: now,
        metadata: metadata,
        flow: flow,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.flow, flow);
    });

    test('copyWith updates fields correctly', () {
      final record = MenstrualFlowInstantRecord(
        time: now,
        metadata: metadata,
        flow: flow,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      const newFlow = MenstrualFlow.light;

      final updatedRecord = record.copyWith(
        time: newTime,
        flow: newFlow,
      );

      expect(updatedRecord.time, newTime.toUtc());
      expect(updatedRecord.flow, newFlow);
      expect(updatedRecord.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = MenstrualFlowInstantRecord(
        time: now,
        metadata: metadata,
        flow: flow,
      );

      final record2 = MenstrualFlowInstantRecord(
        time: now,
        metadata: metadata,
        flow: flow,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
