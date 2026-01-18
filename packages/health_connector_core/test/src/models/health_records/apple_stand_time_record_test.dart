import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('AppleStandTimeRecord', () {
    final now = DateTime(2026, 1, 18);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validDuration = TimeDuration.minutes(45);

    test('equality works correctly', () {
      final record1 = AppleStandTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        standTime: validDuration,
        metadata: metadata,
      );

      final record2 = AppleStandTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        standTime: validDuration,
        metadata: metadata,
      );

      final record3 = AppleStandTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        standTime: const TimeDuration.minutes(30),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
