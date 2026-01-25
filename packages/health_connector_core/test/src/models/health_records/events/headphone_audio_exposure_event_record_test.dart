import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeadphoneAudioExposureEventRecord', () {
    final now = DateTime(2026, 1, 22);
    final endTime = now.add(const Duration(minutes: 5));
    final metadata = Metadata.manualEntry();

    test('can be instantiated with valid parameters', () {
      final record = HeadphoneAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = HeadphoneAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );
      final record2 = HeadphoneAudioExposureEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
