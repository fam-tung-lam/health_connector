import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SystolicBloodPressureRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validValue = Pressure.millimetersOfMercury(120);

    test('can be instantiated with valid parameters', () {
      final record = SystolicBloodPressureRecord(
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
        () => SystolicBloodPressureRecord(
          time: now,
          pressure: const Pressure.millimetersOfMercury(49.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('accepts maximum valid pressure', () {
      final record = SystolicBloodPressureRecord(
        time: now,
        pressure: const Pressure.millimetersOfMercury(300.0), // New max
        metadata: metadata,
      );

      expect(record.pressure.inMillimetersOfMercury, equals(300.0));
    });

    test('throws ArgumentError when pressure is above maxPressure', () {
      expect(
        () => SystolicBloodPressureRecord(
          time: now,
          pressure: const Pressure.millimetersOfMercury(301.0), // Above 300
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = SystolicBloodPressureRecord(
        time: now,
        pressure: validValue,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newPressure = Pressure.millimetersOfMercury(130);
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
