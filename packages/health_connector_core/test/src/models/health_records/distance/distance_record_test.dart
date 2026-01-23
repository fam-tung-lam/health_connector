import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DistanceRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 10));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validValue = Length.meters(1000);

    test('can be instantiated with valid parameters', () {
      final record = DistanceRecord(
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

    test('throws ArgumentError when distance is below minDistance', () {
      expect(
        () => DistanceRecord(
          startTime: startTime,
          endTime: endTime,
          distance: const Length.meters(-1.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when distance is above maxDistance', () {
      expect(
        () => DistanceRecord(
          startTime: startTime,
          endTime: endTime,
          distance: const Length.kilometers(1001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime is not after startTime', () {
      expect(
        () => DistanceRecord(
          startTime: endTime,
          endTime: startTime,
          distance: validValue,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newDist = Length.meters(2000.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        distance: newDist,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.distance, newDist);
      expect(updated.metadata, newMetadata);
    });
  });
}
