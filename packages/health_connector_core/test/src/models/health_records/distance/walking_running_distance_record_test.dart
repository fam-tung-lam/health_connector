import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingRunningDistanceRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validValue = Length.meters(5000);

    test('can be instantiated with valid parameters', () {
      final record = WalkingRunningDistanceRecord(
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

    test('throws ArgumentError when endTime is not after startTime', () {
      expect(
        () => WalkingRunningDistanceRecord(
          startTime: endTime,
          endTime: startTime,
          distance: validValue,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime equals startTime', () {
      expect(
        () => WalkingRunningDistanceRecord(
          startTime: startTime,
          endTime: startTime,
          distance: validValue,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('.internal allows instantaneous samples (endTime == startTime)', () {
      final record = WalkingRunningDistanceRecord.internal(
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

    test('.internal skips distance bounds validation', () {
      final record = WalkingRunningDistanceRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        distance: const Length.kilometers(5000),
        metadata: metadata,
      );

      expect(record.distance, equals(const Length.kilometers(5000)));
    });

    test('copyWith updates fields correctly', () {
      final record = WalkingRunningDistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      const newDist = Length.meters(6000.0);
      final updated = record.copyWith(distance: newDist);

      expect(updated.distance, newDist);
    });
  });
}
