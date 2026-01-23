import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RestingHeartRateRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final validValue = Frequency.perMinute(60);
    final minValue = Frequency.perMinute(1.0); // Updated from 27.0
    final maxValue = Frequency.perMinute(300); // Updated from 120

    test('can be instantiated with valid parameters', () {
      final record = RestingHeartRateRecord(
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.rate, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when rate is too low', () {
      expect(
        () => RestingHeartRateRecord(
          time: now,
          rate: Frequency.perMinute(0.5), // Below 1.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('accepts minimum valid rate', () {
      final record = RestingHeartRateRecord(
        time: now,
        rate: minValue, // 1.0 bpm
        metadata: metadata,
      );

      expect(record.rate, equals(minValue));
    });

    test('accepts maximum valid rate', () {
      final record = RestingHeartRateRecord(
        time: now,
        rate: maxValue, // 300 bpm
        metadata: metadata,
      );

      expect(record.rate, equals(maxValue));
    });

    test('throws ArgumentError when rate is too high', () {
      expect(
        () => RestingHeartRateRecord(
          time: now,
          rate: Frequency.perMinute(maxValue.inPerMinute + 1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates fields correctly', () {
      final record = RestingHeartRateRecord(
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      final updatedRecord = record.copyWith(
        time: newTime,
        rate: Frequency.perMinute(validValue.inPerMinute + 10),
      );

      expect(updatedRecord.time, newTime.toUtc());
      expect(
        updatedRecord.rate.inPerMinute,
        closeTo(validValue.inPerMinute + 10, 0.1),
      );
      expect(updatedRecord.metadata, metadata);
    });

    test('equality works correctly', () {
      final record1 = RestingHeartRateRecord(
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      final record2 = RestingHeartRateRecord(
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
