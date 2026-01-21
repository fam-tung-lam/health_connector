import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HighHeartRateEventRecord', () {
    final now = DateTime(2026, 1, 20);
    final metadata = Metadata.manualEntry();
    final validThreshold = Frequency.perMinute(120.0);

    test('equality works correctly', () {
      final record1 = HighHeartRateEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(minutes: 5)),
        rateThreshold: validThreshold,
        metadata: metadata,
      );

      final record2 = HighHeartRateEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(minutes: 5)),
        rateThreshold: validThreshold,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
