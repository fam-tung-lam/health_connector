import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('MoveTimeRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validDuration = TimeDuration.minutes(30);

    test('equality works correctly', () {
      final record1 = MoveTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        moveTime: validDuration,
        metadata: metadata,
      );

      final record2 = MoveTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        moveTime: validDuration,
        metadata: metadata,
      );

      final record3 = MoveTimeRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        moveTime: const TimeDuration.minutes(15),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
