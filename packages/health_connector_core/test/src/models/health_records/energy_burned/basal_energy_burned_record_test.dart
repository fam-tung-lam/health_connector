import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('BasalEnergyBurnedRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validEnergy = Energy.kilocalories(60);

    test('can be instantiated with valid parameters', () {
      final record = BasalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.energy, equals(validEnergy));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when energy is below minEnergy', () {
      expect(
        () => BasalEnergyBurnedRecord(
          startTime: startTime,
          endTime: endTime,
          energy: const Energy.kilocalories(-0.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when energy is above maxEnergy', () {
      expect(
        () => BasalEnergyBurnedRecord(
          startTime: startTime,
          endTime: endTime,
          energy: const Energy.kilocalories(5001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = BasalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newEnergy = Energy.kilocalories(70);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        energy: newEnergy,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime.toUtc());
      expect(updatedRecord.energy, newEnergy);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = BasalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record2 = BasalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record3 = BasalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: const Energy.kilocalories(70),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
