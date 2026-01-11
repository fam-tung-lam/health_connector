import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryEnergyConsumedRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validEnergy = Energy.kilocalories(250);

    test('can be instantiated with valid parameters', () {
      final record = DietaryEnergyConsumedRecord(
        time: now,
        metadata: metadata,
        energy: validEnergy,
        foodName: 'Apple',
        mealType: MealType.snack,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.energy, equals(validEnergy));
      expect(record.foodName, 'Apple');
      expect(record.mealType, MealType.snack);
    });

    test('throws ArgumentError when energy is below minEnergy', () {
      expect(
        () => DietaryEnergyConsumedRecord(
          time: now,
          metadata: metadata,
          energy: const Energy.kilocalories(-1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when energy is above maxEnergy', () {
      expect(
        () => DietaryEnergyConsumedRecord(
          time: now,
          metadata: metadata,
          energy: const Energy.kilocalories(10001),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryEnergyConsumedRecord(
        time: now,
        metadata: metadata,
        energy: validEnergy,
        foodName: 'Apple',
        mealType: MealType.snack,
      );

      final newTime = now.subtract(const Duration(minutes: 5));
      const newEnergy = Energy.kilocalories(300);
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Banana';
      const newMealType = MealType.breakfast;

      final updatedRecord = record.copyWith(
        time: newTime,
        energy: newEnergy,
        metadata: newMetadata,
        foodName: newFoodName,
        mealType: newMealType,
      );

      expect(updatedRecord.time, newTime);
      expect(updatedRecord.energy, newEnergy);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.foodName, newFoodName);
      expect(updatedRecord.mealType, newMealType);
    });

    test('equality works correctly', () {
      final record1 = DietaryEnergyConsumedRecord(
        time: now,
        metadata: metadata,
        energy: validEnergy,
      );

      final record2 = DietaryEnergyConsumedRecord(
        time: now,
        metadata: metadata,
        energy: validEnergy,
      );

      final record3 = DietaryEnergyConsumedRecord(
        time: now,
        metadata: metadata,
        energy: const Energy.kilocalories(300),
      );

      expect(record1 == record2, isTrue);
      expect(record1.hashCode, equals(record2.hashCode));
      expect(record1 == record3, isFalse);
    });
  });
}
