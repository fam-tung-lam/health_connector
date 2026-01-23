import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ElevationGainedRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(minutes: 10));
    final metadata = Metadata.manualEntry();
    const validElevation = Length.meters(100.0);

    test('can be instantiated with valid parameters', () {
      final record = ElevationGainedRecord(
        startTime: now,
        endTime: endTime,
        elevation: validElevation,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.elevation, validElevation);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when elevation is below minElevation', () {
      expect(
        () => ElevationGainedRecord(
          startTime: now,
          endTime: endTime,
          elevation: const Length.meters(-1000001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when elevation is above maxElevation', () {
      expect(
        () => ElevationGainedRecord(
          startTime: now,
          endTime: endTime,
          elevation: const Length.meters(1000001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = ElevationGainedRecord(
        startTime: now,
        endTime: endTime,
        elevation: validElevation,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(minutes: 5));
      final newEndTime = endTime.add(const Duration(minutes: 5));
      const newElevation = Length.meters(200.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        elevation: newElevation,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.elevation, newElevation);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ElevationGainedRecord(
        startTime: now,
        endTime: endTime,
        elevation: validElevation,
        metadata: metadata,
      );
      final record2 = ElevationGainedRecord(
        startTime: now,
        endTime: endTime,
        elevation: validElevation,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = ElevationGainedRecord(
        startTime: now,
        endTime: endTime,
        elevation: const Length.meters(200.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
