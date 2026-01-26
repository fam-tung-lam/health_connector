import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PeakExpiratoryFlowRateRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 5));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validVolumePerSecond = Volume.liters(6.0);

    test('can be instantiated with valid parameters', () {
      final record = PeakExpiratoryFlowRateRecord(
        startTime: startTime,
        endTime: endTime,
        volumePerSecond: validVolumePerSecond,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.volumePerSecond, equals(validVolumePerSecond));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => PeakExpiratoryFlowRateRecord(
          startTime: endTime,
          endTime: startTime,
          volumePerSecond: validVolumePerSecond,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = PeakExpiratoryFlowRateRecord(
        startTime: startTime,
        endTime: endTime,
        volumePerSecond: validVolumePerSecond,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newVolumePerSecond = Volume.liters(7.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        volumePerSecond: newVolumePerSecond,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.volumePerSecond, newVolumePerSecond);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = PeakExpiratoryFlowRateRecord(
        startTime: startTime,
        endTime: endTime,
        volumePerSecond: validVolumePerSecond,
        metadata: metadata,
      );

      final record2 = PeakExpiratoryFlowRateRecord(
        startTime: startTime,
        endTime: endTime,
        volumePerSecond: validVolumePerSecond,
        metadata: metadata,
      );

      final record3 = PeakExpiratoryFlowRateRecord(
        startTime: startTime,
        endTime: endTime,
        volumePerSecond: const Volume.liters(7.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
