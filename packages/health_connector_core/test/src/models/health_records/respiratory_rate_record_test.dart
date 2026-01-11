import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RespiratoryRateRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final validRate = Frequency.perMinute(16.0);

    test('can be instantiated with valid parameters', () {
      final record = RespiratoryRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.rate, validRate);
      expect(record.metadata, metadata);
    });

    test('accepts minimum valid rate', () {
      final record = RespiratoryRateRecord(
        time: now,
        rate: Frequency.perMinute(0.0), // New min is 0.0
        metadata: metadata,
      );

      expect(record.rate.inPerMinute, equals(0.0));
    });

    test('throws ArgumentError when rate is below minRate', () {
      expect(
        () => RespiratoryRateRecord(
          time: now,
          rate: Frequency.perMinute(-1.0), // Below 0.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('accepts maximum valid rate', () {
      final record = RespiratoryRateRecord(
        time: now,
        rate: Frequency.perMinute(1000.0), // New max is 1000.0
        metadata: metadata,
      );

      expect(record.rate.inPerMinute, equals(1000.0));
    });

    test('throws ArgumentError when rate is above maxRate', () {
      expect(
        () => RespiratoryRateRecord(
          time: now,
          rate: Frequency.perMinute(1001.0), // Above 1000.0
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = RespiratoryRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      final newRate = Frequency.perMinute(20.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        rate: newRate,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.rate, newRate);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = RespiratoryRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final record2 = RespiratoryRateRecord(
        time: now,
        rate: validRate,
        metadata: metadata,
      );

      final record3 = RespiratoryRateRecord(
        time: now,
        rate: Frequency.perMinute(18.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
