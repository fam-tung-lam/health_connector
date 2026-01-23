import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RunningSpeedRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validSpeed = Velocity.kilometersPerHour(10.0);

    test('can be instantiated with valid parameters', () {
      final record = RunningSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.speed, validSpeed);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when speed is below minSpeed', () {
      expect(
        () => RunningSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when speed is above maxSpeed', () {
      expect(
        () => RunningSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(50.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = RunningSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newSpeed = Velocity.kilometersPerHour(12.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        speed: newSpeed,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.speed, newSpeed);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = RunningSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record2 = RunningSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record3 = RunningSpeedRecord(
        time: now,
        speed: const Velocity.kilometersPerHour(10.1),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
