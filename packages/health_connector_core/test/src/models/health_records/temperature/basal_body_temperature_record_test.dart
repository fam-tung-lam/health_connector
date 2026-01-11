import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BasalBodyTemperatureRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    final validTemp = Temperature.celsius(36.5);

    test('can be instantiated with valid parameters', () {
      final record = BasalBodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.temperature, equals(validTemp));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when temperature is below minTemperature', () {
      expect(
        () => BasalBodyTemperatureRecord(
          time: now,
          temperature: const Temperature.celsius(20.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when temperature is above maxTemperature', () {
      expect(
        () => BasalBodyTemperatureRecord(
          time: now,
          temperature: const Temperature.celsius(45.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BasalBodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      final newTemp = Temperature.celsius(37.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        temperature: newTemp,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.temperature, newTemp);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BasalBodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final record2 = BasalBodyTemperatureRecord(
        time: now,
        temperature: validTemp,
        metadata: metadata,
      );

      final record3 = BasalBodyTemperatureRecord(
        time: now,
        temperature: const Temperature.celsius(37.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
