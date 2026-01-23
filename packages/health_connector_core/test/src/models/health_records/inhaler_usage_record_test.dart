import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('InhalerUsageRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const puffs = Number(2);

    test('can be instantiated with valid parameters', () {
      final record = InhalerUsageRecord(
        startTime: startTime,
        endTime: endTime,
        puffs: puffs,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.puffs, puffs);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when puffs is negative', () {
      expect(
        () => InhalerUsageRecord(
          startTime: startTime,
          endTime: endTime,
          puffs: const Number(-1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime is not after startTime', () {
      expect(
        () => InhalerUsageRecord(
          startTime: startTime,
          endTime: startTime,
          puffs: puffs,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('internal factory creates record without validation', () {
      final id = HealthRecordId('test-id');
      final record = InhalerUsageRecord.internal(
        id: id,
        startTime: startTime,
        endTime: endTime,
        puffs: const Number(-1),
        // Invalid but allowed in internal
        metadata: metadata,
      );

      expect(record.id, id);
      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.puffs.value, -1);
    });

    test('copyWith updates all fields correctly', () {
      final record = InhalerUsageRecord(
        startTime: startTime,
        endTime: endTime,
        puffs: puffs,
        metadata: metadata,
      );

      final newStartTime = startTime.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newPuffs = Number(3);
      final newMetadata = Metadata.manualEntry();
      final newId = HealthRecordId('new-id');

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        puffs: newPuffs,
        metadata: newMetadata,
        id: newId,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.puffs, newPuffs);
      expect(updated.metadata, newMetadata);
      expect(updated.id, newId);
    });

    test('equality works correctly', () {
      final record1 = InhalerUsageRecord(
        startTime: startTime,
        endTime: endTime,
        puffs: puffs,
        metadata: metadata,
      );
      final record2 = InhalerUsageRecord(
        startTime: startTime,
        endTime: endTime,
        puffs: puffs,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = record1.copyWith(puffs: const Number(1));

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
