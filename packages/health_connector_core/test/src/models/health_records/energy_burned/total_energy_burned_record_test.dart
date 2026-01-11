import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('TotalEnergyBurnedRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validEnergy = Energy.kilocalories(450);

    test('can be instantiated with valid parameters', () {
      final record = TotalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.energy, equals(validEnergy));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when energy is below minEnergy', () {
      expect(
        () => TotalEnergyBurnedRecord(
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
        () => TotalEnergyBurnedRecord(
          startTime: startTime,
          endTime: endTime,
          energy: const Energy.kilocalories(20001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = TotalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newEnergy = Energy.kilocalories(500);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        energy: newEnergy,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.energy, newEnergy);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = TotalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record2 = TotalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record3 = TotalEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: const Energy.kilocalories(500),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
