import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BloodGlucoseRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validValue = BloodGlucose.millimolesPerLiter(5.5);

    test('can be instantiated with valid parameters', () {
      final record = BloodGlucoseRecord(
        time: now,
        glucoseLevel: validValue,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(
        record.glucoseLevel,
        equals(validValue),
      );
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when glucoseLevel is below '
        'minBloodGlucose', () {
      expect(
        () => BloodGlucoseRecord(
          time: now,
          glucoseLevel: const BloodGlucose.milligramsPerDeciliter(19.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when glucoseLevel is above '
        'maxBloodGlucose', () {
      expect(
        () => BloodGlucoseRecord(
          time: now,
          glucoseLevel: const BloodGlucose.milligramsPerDeciliter(701.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BloodGlucoseRecord(
        time: now,
        glucoseLevel: validValue,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newGlucose = BloodGlucose.millimolesPerLiter(6.0);
      final newMetadata = Metadata.manualEntry();
      final updated = record.copyWith(
        time: newTime,
        glucoseLevel: newGlucose,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.glucoseLevel, newGlucose);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BloodGlucoseRecord(
        time: now,
        glucoseLevel: validValue,
        metadata: metadata,
      );
      final record2 = BloodGlucoseRecord(
        time: now,
        glucoseLevel: validValue,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = BloodGlucoseRecord(
        time: now,
        glucoseLevel: const BloodGlucose.millimolesPerLiter(6.0),
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
