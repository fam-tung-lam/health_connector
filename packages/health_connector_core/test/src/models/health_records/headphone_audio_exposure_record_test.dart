import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeadphoneAudioExposureRecord', () {
    final now = DateTime(2026, 1, 22);
    final endTime = now.add(const Duration(minutes: 10));
    final metadata = Metadata.manualEntry();
    const decibel = Number(55.0);

    test('can be instantiated with valid parameters', () {
      final record = HeadphoneAudioExposureRecord(
        startTime: now,
        endTime: endTime,
        aWeightedDecibel: decibel,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.aWeightedDecibel, decibel);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => HeadphoneAudioExposureRecord(
          startTime: now,
          endTime: now.subtract(const Duration(minutes: 1)),
          aWeightedDecibel: decibel,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = HeadphoneAudioExposureRecord(
        startTime: now,
        endTime: endTime,
        aWeightedDecibel: decibel,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newDecibel = Number(60.0);
      final newMetadata = Metadata.manualEntry(clientRecordId: 'updated');

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        aWeightedDecibel: newDecibel,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.aWeightedDecibel, newDecibel);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = HeadphoneAudioExposureRecord(
        startTime: now,
        endTime: endTime,
        aWeightedDecibel: decibel,
        metadata: metadata,
      );
      final record2 = HeadphoneAudioExposureRecord(
        startTime: now,
        endTime: endTime,
        aWeightedDecibel: decibel,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = HeadphoneAudioExposureRecord(
        startTime: now,
        endTime: endTime,
        aWeightedDecibel: const Number(60.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
