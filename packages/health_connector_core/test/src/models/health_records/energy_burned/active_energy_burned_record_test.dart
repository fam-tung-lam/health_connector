import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ActiveEnergyBurnedRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validEnergy = Energy.kilocalories(300);

    test('can be instantiated with valid parameters', () {
      final record = ActiveEnergyBurnedRecord(
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
        () => ActiveEnergyBurnedRecord(
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
        () => ActiveEnergyBurnedRecord(
          startTime: startTime,
          endTime: endTime,
          energy: const Energy.kilocalories(15001.0),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = ActiveEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      final newEndTime = endTime.add(const Duration(minutes: 10));
      const newEnergy = Energy.kilocalories(350);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        energy: newEnergy,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.endTime, newEndTime);
      expect(updatedRecord.energy, newEnergy);
      expect(updatedRecord.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ActiveEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record2 = ActiveEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: validEnergy,
        metadata: metadata,
      );

      final record3 = ActiveEnergyBurnedRecord(
        startTime: startTime,
        endTime: endTime,
        energy: const Energy.kilocalories(350),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
