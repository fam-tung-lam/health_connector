import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DiastolicBloodPressureRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validValue = Pressure.millimetersOfMercury(80);

    test('can be instantiated with valid parameters', () {
      final record = DiastolicBloodPressureRecord(
        time: now,
        pressure: validValue,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.pressure, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when pressure is below minPressure', () {
      expect(
        () => DiastolicBloodPressureRecord(
          time: now,
          pressure: const Pressure.millimetersOfMercury(29.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('accepts maximum valid pressure', () {
      final record = DiastolicBloodPressureRecord(
        time: now,
        pressure: const Pressure.millimetersOfMercury(300.0), // New max
        metadata: metadata,
      );

      expect(record.pressure.inMillimetersOfMercury, equals(300.0));
    });

    test('throws ArgumentError when pressure is above maxPressure', () {
      expect(
        () => DiastolicBloodPressureRecord(
          time: now,
          pressure: const Pressure.millimetersOfMercury(301.0), // Above 300
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DiastolicBloodPressureRecord(
        time: now,
        pressure: validValue,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPressure = Pressure.millimetersOfMercury(90);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        pressure: newPressure,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.pressure, newPressure);
      expect(updated.metadata, newMetadata);
    });
  });
}
