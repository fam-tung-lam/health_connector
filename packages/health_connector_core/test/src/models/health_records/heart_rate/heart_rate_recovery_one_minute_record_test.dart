import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeartRateRecoveryOneMinuteRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 1);
    final metadata = Metadata.manualEntry();
    const heartRateCount = Number(15.0);

    test('constructor enforces validation', () {
      // Valid record
      expect(
        () => HeartRateRecoveryOneMinuteRecord(
          startTime: startTime,
          endTime: endTime,
          heartRateCount: heartRateCount,
          metadata: metadata,
        ),
        returnsNormally,
      );

      // Negative heart rate
      expect(
        () => HeartRateRecoveryOneMinuteRecord(
          startTime: startTime,
          endTime: endTime,
          heartRateCount: const Number(-1.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );

      // Too high heart rate
      expect(
        () => HeartRateRecoveryOneMinuteRecord(
          startTime: startTime,
          endTime: endTime,
          heartRateCount: const Number(201.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final record1 = HeartRateRecoveryOneMinuteRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        heartRateCount: heartRateCount,
        metadata: metadata,
      );

      final record2 = HeartRateRecoveryOneMinuteRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        heartRateCount: heartRateCount,
        metadata: metadata,
      );

      final differentRecord = record1.copyWith(
        heartRateCount: const Number(20.0),
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
      expect(record1, isNot(equals(differentRecord)));
    });

    test('copyWith works correctly', () {
      final record = HeartRateRecoveryOneMinuteRecord(
        startTime: startTime,
        endTime: endTime,
        heartRateCount: heartRateCount,
        metadata: metadata,
      );

      final updatedStartTime = startTime.add(const Duration(seconds: 10));
      final updatedEndTime = endTime.add(const Duration(seconds: 20));
      final copiedRecord = record.copyWith(
        startTime: updatedStartTime,
        endTime: updatedEndTime,
      );

      expect(copiedRecord.startTime, equals(updatedStartTime));
      expect(copiedRecord.endTime, equals(updatedEndTime));
      expect(copiedRecord.heartRateCount, equals(heartRateCount));
    });
  });
}
