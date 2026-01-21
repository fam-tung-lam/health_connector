import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingHeartRateAverageRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 30);
    final metadata = Metadata.manualEntry();
    final validValue = Frequency.perMinute(95);

    test('equality works correctly', () {
      final record1 = WalkingHeartRateAverageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        rate: validValue,
        metadata: metadata,
      );

      final record2 = WalkingHeartRateAverageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        rate: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
