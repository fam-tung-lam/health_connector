import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BloodPressureRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validSystolic = Pressure.millimetersOfMercury(120);
    const validDiastolic = Pressure.millimetersOfMercury(80);

    test('can be instantiated with valid parameters', () {
      final record = BloodPressureRecord(
        time: now,
        systolic: validSystolic,
        diastolic: validDiastolic,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.systolic, equals(validSystolic));
      expect(record.diastolic, equals(validDiastolic));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when systolic is below minSystolic', () {
      expect(
        () => BloodPressureRecord(
          time: now,
          systolic: const Pressure.millimetersOfMercury(49.0),
          diastolic: validDiastolic,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when systolic is above maxSystolic', () {
      expect(
        () => BloodPressureRecord(
          time: now,
          systolic: const Pressure.millimetersOfMercury(301.0),
          diastolic: validDiastolic,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when diastolic is below minDiastolic', () {
      expect(
        () => BloodPressureRecord(
          time: now,
          systolic: validSystolic,
          diastolic: const Pressure.millimetersOfMercury(29.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when diastolic is above maxDiastolic', () {
      expect(
        () => BloodPressureRecord(
          time: now,
          systolic: validSystolic,
          diastolic: const Pressure.millimetersOfMercury(301.0), // Above 300
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when systolic is less than diastolic', () {
      expect(
        () => BloodPressureRecord(
          time: now,
          systolic: const Pressure.millimetersOfMercury(80.0),
          diastolic: const Pressure.millimetersOfMercury(90.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BloodPressureRecord(
        time: now,
        systolic: validSystolic,
        diastolic: validDiastolic,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newSystolic = Pressure.millimetersOfMercury(130);
      const newDiastolic = Pressure.millimetersOfMercury(90);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        systolic: newSystolic,
        diastolic: newDiastolic,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.systolic, newSystolic);
      expect(updated.diastolic, newDiastolic);
      expect(updated.metadata, newMetadata);
    });
  });
}
