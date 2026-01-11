import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeartRateRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final validValue = Frequency.perMinute(72.0);
    final minValue = Frequency.perMinute(1.0); // Updated from 27.0
    final maxValue = Frequency.perMinute(300.0); // Updated from 240.0

    test('can be instantiated with valid parameters', () {
      final record = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.rate, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when rate is below minRate', () {
      expect(
        () => HeartRateRecord(
          id: HealthRecordId.none,
          time: now,
          rate: Frequency.perMinute(0.5), // Below 1.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('accepts minimum valid rate', () {
      final record = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: minValue, // 1.0 bpm
        metadata: metadata,
      );

      expect(record.rate, equals(minValue));
    });

    test('accepts maximum valid rate', () {
      final record = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: maxValue, // 300.0 bpm
        metadata: metadata,
      );

      expect(record.rate, equals(maxValue));
    });

    test('throws ArgumentError when rate is above maxRate', () {
      expect(
        () => HeartRateRecord(
          id: HealthRecordId.none,
          time: now,
          rate: Frequency.perMinute(maxValue.inPerMinute + 1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates fields correctly', () {
      final record = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      final newRate = Frequency.perMinute(validValue.inPerMinute + 10);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        time: newTime,
        rate: newRate,
        metadata: newMetadata,
      );

      expect(updatedRecord.time, newTime);
      expect(updatedRecord.rate, newRate);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      final record2 = HeartRateRecord(
        id: HealthRecordId.none,
        time: now,
        rate: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
