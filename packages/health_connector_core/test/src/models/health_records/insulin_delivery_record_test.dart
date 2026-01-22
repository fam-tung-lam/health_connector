import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('InsulinDeliveryRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validUnits = Number(10.5);

    test('can be instantiated with valid parameters', () {
      final record = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.units, validUnits);
      expect(record.metadata, metadata);
    });

    test('can be instantiated with minimum units', () {
      final record = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: InsulinDeliveryRecord.minUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      expect(record.units, InsulinDeliveryRecord.minUnits);
    });

    test('can be instantiated with maximum units', () {
      final record = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: InsulinDeliveryRecord.maxUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      expect(record.units, InsulinDeliveryRecord.maxUnits);
    });

    test('throws ArgumentError when units is below minUnits', () {
      expect(
        () => InsulinDeliveryRecord(
          startTime: startTime,
          endTime: endTime,
          units: const Number(-0.1),
          reason: InsulinDeliveryReason.basal,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when units is above maxUnits', () {
      expect(
        () => InsulinDeliveryRecord(
          startTime: startTime,
          endTime: endTime,
          units: const Number(500.1),
          reason: InsulinDeliveryReason.basal,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when end time is before start time', () {
      expect(
        () => InsulinDeliveryRecord(
          startTime: endTime,
          endTime: startTime,
          units: validUnits,
          reason: InsulinDeliveryReason.basal,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newUnits = Number(15.0);
      final newMetadata = Metadata.manualEntry();
      final newId = HealthRecordId('new-id');

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        units: newUnits,
        metadata: newMetadata,
        id: newId,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.units, newUnits);
      expect(updated.metadata, newMetadata);
      expect(updated.id, newId);
    });

    test('copyWith preserves fields when not provided', () {
      final record = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      final updated = record.copyWith();

      expect(updated.startTime, startTime);
      expect(updated.endTime, endTime);
      expect(updated.units, validUnits);
      expect(updated.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      final record2 = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      final record3 = InsulinDeliveryRecord(
        startTime: startTime,
        endTime: endTime,
        units: const Number(15.0),
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    test('equality considers all fields', () {
      final record1 = InsulinDeliveryRecord(
        id: HealthRecordId('id-1'),
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      final record2 = InsulinDeliveryRecord(
        id: HealthRecordId('id-1'),
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      final record3 = InsulinDeliveryRecord(
        id: HealthRecordId('id-2'),
        startTime: startTime,
        endTime: endTime,
        units: validUnits,
        reason: InsulinDeliveryReason.basal,
        metadata: metadata,
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
    });
  });
}
