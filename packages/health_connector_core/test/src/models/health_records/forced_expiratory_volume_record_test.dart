import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ForcedExpiratoryVolumeRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const volume = Volume.liters(2.5);

    test('can be instantiated with valid parameters', () {
      final record = ForcedExpiratoryVolumeRecord(
        startTime: startTime,
        endTime: endTime,
        volume: volume,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.volume, volume);
      expect(record.metadata, metadata);
    });

    test('copyWith updates all fields correctly', () {
      final record = ForcedExpiratoryVolumeRecord(
        startTime: startTime,
        endTime: endTime,
        volume: volume,
        metadata: metadata,
      );

      final newStartTime = startTime.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newVolume = Volume.liters(3.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        volume: newVolume,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime);
      expect(updated.endTime, newEndTime);
      expect(updated.volume, newVolume);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ForcedExpiratoryVolumeRecord(
        startTime: startTime,
        endTime: endTime,
        volume: volume,
        metadata: metadata,
      );
      final record2 = ForcedExpiratoryVolumeRecord(
        startTime: startTime,
        endTime: endTime,
        volume: volume,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = ForcedExpiratoryVolumeRecord(
        startTime: startTime,
        endTime: endTime,
        volume: const Volume.liters(3.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
