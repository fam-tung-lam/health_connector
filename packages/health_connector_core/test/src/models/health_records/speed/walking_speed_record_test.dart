import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingSpeedRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validSpeed = Velocity.kilometersPerHour(5.0);

    test('can be instantiated with valid parameters', () {
      final record = WalkingSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.speed, validSpeed);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when speed is below minSpeed', () {
      expect(
        () => WalkingSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when speed is above maxSpeed', () {
      expect(
        () => WalkingSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(12.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = WalkingSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newSpeed = Velocity.kilometersPerHour(5.5);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        speed: newSpeed,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.speed, newSpeed);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = WalkingSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record2 = WalkingSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record3 = WalkingSpeedRecord(
        time: now,
        speed: const Velocity.kilometersPerHour(5.1),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
