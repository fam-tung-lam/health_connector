import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeartRateVariabilityRMSSDRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validValue = TimeDuration.milliseconds(50);
    const maxValue = TimeDuration.milliseconds(250);

    test('can be instantiated with valid parameters', () {
      final record = HeartRateVariabilityRMSSDRecord(
        time: now,
        rmssd: validValue,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.rmssd, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when rmssd is too low', () {
      expect(
        () => HeartRateVariabilityRMSSDRecord(
          time: now,
          rmssd: const TimeDuration.milliseconds(0.9), // Min is 1.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when rmssd is too high', () {
      expect(
        () => HeartRateVariabilityRMSSDRecord(
          time: now,
          rmssd: TimeDuration.milliseconds(maxValue.inMilliseconds + 0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates fields correctly', () {
      final record = HeartRateVariabilityRMSSDRecord(
        time: now,
        rmssd: validValue,
        metadata: metadata,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      final updatedRecord = record.copyWith(
        time: newTime,
        rmssd: TimeDuration.milliseconds(validValue.inMilliseconds + 10),
      );

      expect(updatedRecord.time, newTime.toUtc());
      expect(
        updatedRecord.rmssd.inMilliseconds,
        closeTo(validValue.inMilliseconds + 10, 0.1),
      );
      expect(updatedRecord.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = HeartRateVariabilityRMSSDRecord(
        time: now,
        rmssd: validValue,
        metadata: metadata,
      );

      final record2 = HeartRateVariabilityRMSSDRecord(
        time: now,
        rmssd: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
