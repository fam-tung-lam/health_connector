import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('CyclingPedalingCadenceRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final validCadence = Frequency.perMinute(90);

    test('can be instantiated with valid parameters', () {
      final record = CyclingPedalingCadenceRecord(
        id: HealthRecordId.none,
        time: now,
        cadence: validCadence,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.cadence, equals(validCadence));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when cadence is below minCadence', () {
      expect(
        () => CyclingPedalingCadenceRecord(
          id: HealthRecordId.none,
          time: now,
          cadence: Frequency.perMinute(-1.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when cadence is above maxCadence', () {
      expect(
        () => CyclingPedalingCadenceRecord(
          id: HealthRecordId.none,
          time: now,
          cadence: Frequency.perMinute(201.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = CyclingPedalingCadenceRecord(
        id: HealthRecordId.none,
        time: now,
        cadence: validCadence,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      final newCadence = Frequency.perMinute(100);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        cadence: newCadence,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.cadence, newCadence);
      expect(updated.metadata, newMetadata);
    });
  });
}
