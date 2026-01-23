import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HydrationRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validVolume = Volume.milliliters(500.0);

    test('can be instantiated with valid parameters', () {
      final record = HydrationRecord(
        startTime: startTime,
        endTime: endTime,
        volume: validVolume,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.volume, validVolume);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when volume is below minVolume', () {
      expect(
        () => HydrationRecord(
          startTime: startTime,
          endTime: endTime,
          volume: const Volume.liters(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when volume is above maxVolume', () {
      expect(
        () => HydrationRecord(
          startTime: startTime,
          endTime: endTime,
          volume: const Volume.liters(20.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when end time is before start time', () {
      expect(
        () => HydrationRecord(
          startTime: endTime,
          endTime: startTime,
          volume: validVolume,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = HydrationRecord(
        startTime: startTime,
        endTime: endTime,
        volume: validVolume,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newVolume = Volume.milliliters(600.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        volume: newVolume,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.volume, newVolume);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = HydrationRecord(
        startTime: startTime,
        endTime: endTime,
        volume: validVolume,
        metadata: metadata,
      );

      final record2 = HydrationRecord(
        startTime: startTime,
        endTime: endTime,
        volume: validVolume,
        metadata: metadata,
      );

      final record3 = HydrationRecord(
        startTime: startTime,
        endTime: endTime,
        volume: const Volume.milliliters(550.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
