import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('EnvironmentalAudioExposureEventRecord', () {
    final now = DateTime(2026, 1, 22);
    final endTime = now.add(const Duration(minutes: 5));
    final metadata = Metadata.manualEntry();
    const decibel = Number(85.0);

    test('can be instantiated with valid parameters', () {
      final record = EnvironmentalAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        aWeightedDecibel: decibel,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.aWeightedDecibel, decibel);
      expect(record.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = EnvironmentalAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        aWeightedDecibel: decibel,
      );
      final record2 = EnvironmentalAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        aWeightedDecibel: decibel,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
