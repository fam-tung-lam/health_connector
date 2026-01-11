import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeartRateVariabilitySDNNRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validValue = TimeDuration.milliseconds(50);
    const maxValue = TimeDuration.milliseconds(300);

    test('can be instantiated with valid parameters', () {
      final record = HeartRateVariabilitySDNNRecord(
        time: now,
        sdnn: validValue,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.sdnn, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when sdnn is too low', () {
      expect(
        () => HeartRateVariabilitySDNNRecord(
          time: now,
          sdnn: const TimeDuration.milliseconds(0.9), // Min is 1.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when sdnn is too high', () {
      expect(
        () => HeartRateVariabilitySDNNRecord(
          time: now,
          sdnn: TimeDuration.milliseconds(maxValue.inMilliseconds + 0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates fields correctly', () {
      final record = HeartRateVariabilitySDNNRecord(
        time: now,
        sdnn: validValue,
        metadata: metadata,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      final updatedRecord = record.copyWith(
        time: newTime,
        sdnn: TimeDuration.milliseconds(validValue.inMilliseconds + 10),
      );

      expect(updatedRecord.time, newTime);
      expect(
        updatedRecord.sdnn.inMilliseconds,
        closeTo(validValue.inMilliseconds + 10, 0.1),
      );
      expect(updatedRecord.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = HeartRateVariabilitySDNNRecord(
        time: now,
        sdnn: validValue,
        metadata: metadata,
      );

      final record2 = HeartRateVariabilitySDNNRecord(
        time: now,
        sdnn: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
