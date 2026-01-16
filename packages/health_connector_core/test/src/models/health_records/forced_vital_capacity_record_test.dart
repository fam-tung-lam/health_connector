import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ForcedVitalCapacityRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final volume = Volume.liters(3.5);

    test('can be instantiated with valid parameters', () {
      final record = ForcedVitalCapacityRecord(
        time: now,
        volume: volume,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.volume, volume);
      expect(record.metadata, metadata);
    });

    test('copyWith updates all fields correctly', () {
      final record = ForcedVitalCapacityRecord(
        time: now,
        volume: volume,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      final newVolume = Volume.liters(4.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        volume: newVolume,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.volume, newVolume);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ForcedVitalCapacityRecord(
        time: now,
        volume: volume,
        metadata: metadata,
      );
      final record2 = ForcedVitalCapacityRecord(
        time: now,
        volume: volume,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = ForcedVitalCapacityRecord(
        time: now,
        volume: Volume.liters(3.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
