import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BodyTemperatureRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validTemp = Temperature.celsius(37.0);

    test('can be instantiated with valid parameters', () {
      final record = BodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.temperature, equals(validTemp));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when temperature is below minTemperature', () {
      expect(
        () => BodyTemperatureRecord(
          time: now,
          temperature: Temperature.zero,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when temperature is above maxTemperature', () {
      expect(
        () => BodyTemperatureRecord(
          time: now,
          temperature: const Temperature.celsius(50.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newTemp = Temperature.celsius(38.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        temperature: newTemp,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.temperature, newTemp);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final record2 = BodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final record3 = BodyTemperatureRecord(
        time: now,
        temperature: const Temperature.celsius(38.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
