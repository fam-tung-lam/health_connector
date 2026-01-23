import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('StairAscentSpeedRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validSpeed = Velocity.kilometersPerHour(1.0);

    test('can be instantiated with valid parameters', () {
      final record = StairAscentSpeedRecord(
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
        () => StairAscentSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when speed is above maxSpeed', () {
      expect(
        () => StairAscentSpeedRecord(
          time: now,
          speed: const Velocity.kilometersPerHour(2.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = StairAscentSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newSpeed = Velocity.kilometersPerHour(1.2);
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
      final record1 = StairAscentSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record2 = StairAscentSpeedRecord(
        time: now,
        speed: validSpeed,
        metadata: metadata,
      );

      final record3 = StairAscentSpeedRecord(
        time: now,
        speed: const Velocity.kilometersPerHour(1.1),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
