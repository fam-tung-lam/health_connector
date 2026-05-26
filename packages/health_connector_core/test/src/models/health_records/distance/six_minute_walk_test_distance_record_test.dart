import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group('SixMinuteWalkTestDistanceRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 6));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validValue = Length.meters(500);

    test('can be instantiated with valid parameters', () {
      final record = SixMinuteWalkTestDistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.distance, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime equals startTime', () {
      expect(
        () => SixMinuteWalkTestDistanceRecord(
          startTime: startTime,
          endTime: startTime,
          distance: validValue,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('.internal allows instantaneous samples (endTime == startTime)', () {
      final record = SixMinuteWalkTestDistanceRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: startTime,
        distance: validValue,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, startTime.toUtc());
      expect(record.distance, equals(validValue));
    });

    test('copyWith updates fields correctly', () {
      final record = SixMinuteWalkTestDistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      const newDist = Length.meters(600.0);
      final updated = record.copyWith(distance: newDist);

      expect(updated.distance, newDist);
    });
  });
}
