import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ElectrodermalActivityRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validConductance = Number(15.5);

    test('can be instantiated with valid parameters', () {
      final record = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.conductance, validConductance);
      expect(record.metadata, metadata);
    });

    test('can be instantiated with minimum conductance', () {
      final record = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: ElectrodermalActivityRecord.minConductance,
        metadata: metadata,
      );

      expect(record.conductance, ElectrodermalActivityRecord.minConductance);
    });

    test('can be instantiated with maximum conductance', () {
      final record = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: ElectrodermalActivityRecord.maxConductance,
        metadata: metadata,
      );

      expect(record.conductance, ElectrodermalActivityRecord.maxConductance);
    });

    test('throws ArgumentError when conductance is below minConductance', () {
      expect(
        () => ElectrodermalActivityRecord(
          startTime: startTime,
          endTime: endTime,
          conductance: const Number(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when conductance is above maxConductance', () {
      expect(
        () => ElectrodermalActivityRecord(
          startTime: startTime,
          endTime: endTime,
          conductance: const Number(100.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when end time is before start time', () {
      expect(
        () => ElectrodermalActivityRecord(
          startTime: endTime,
          endTime: startTime,
          conductance: validConductance,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newConductance = Number(25.0);
      final newMetadata = Metadata.manualEntry();
      final newId = HealthRecordId('new-id');

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        conductance: newConductance,
        metadata: newMetadata,
        id: newId,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.conductance, newConductance);
      expect(updated.metadata, newMetadata);
      expect(updated.id, newId);
    });

    test('copyWith preserves fields when not provided', () {
      final record = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
      );

      final updated = record.copyWith();

      expect(updated.startTime, startTime.toUtc());
      expect(updated.endTime, endTime.toUtc());
      expect(updated.conductance, validConductance);
      expect(updated.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
      );

      final record2 = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
      );

      final record3 = ElectrodermalActivityRecord(
        startTime: startTime,
        endTime: endTime,
        conductance: const Number(25.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    test('equality considers all fields', () {
      final record1 = ElectrodermalActivityRecord(
        id: HealthRecordId('id-1'),
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      final record2 = ElectrodermalActivityRecord(
        id: HealthRecordId('id-1'),
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      final record3 = ElectrodermalActivityRecord(
        id: HealthRecordId('id-2'),
        startTime: startTime,
        endTime: endTime,
        conductance: validConductance,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
    });
  });
}
