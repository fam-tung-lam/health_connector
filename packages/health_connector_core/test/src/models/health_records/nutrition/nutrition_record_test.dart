import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('NutritionRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();

    // Test Values
    const energy = Energy.kilocalories(450);
    const protein = Mass.grams(35);
    const carb = Mass.grams(50);
    const fat = Mass.grams(10);
    const vitaminA = Mass.grams(0.000835); // 835 mcg
    const calcium = Mass.grams(0.3); // 300 mg

    test('can be instantiated with valid parameters', () {
      final record = NutritionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        foodName: 'Chicken with Rice',
        mealType: MealType.lunch,
        energy: energy,
        protein: protein,
        totalCarbohydrate: carb,
        totalFat: fat,
        vitaminA: vitaminA,
        calcium: calcium,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.metadata, metadata);
      expect(record.foodName, 'Chicken with Rice');
      expect(record.mealType, MealType.lunch);
      expect(record.energy, equals(energy));
      expect(record.protein, equals(protein));
      expect(record.vitaminA, equals(vitaminA));
      expect(record.calcium, equals(calcium));
    });

    test('validates energy range', () {
      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          energy: const Energy.kilocalories(-1), // Invalid
        ),
        throwsArgumentError,
      );

      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          energy: const Energy.kilocalories(10001), // Invalid
        ),
        throwsArgumentError,
      );
    });

    test('validates macronutrient range', () {
      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          protein: const Mass.grams(-1), // Invalid
        ),
        throwsArgumentError,
      );

      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          protein: const Mass.grams(1001), // Invalid
        ),
        throwsArgumentError,
      );
    });

    test('validates vitamin range', () {
      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          vitaminA: const Mass.grams(-1), // Invalid
        ),
        throwsArgumentError,
      );

      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          vitaminA: const Mass.grams(10.1), // Invalid > 10g
        ),
        throwsArgumentError,
      );
    });

    test('validates mineral range', () {
      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          calcium: const Mass.grams(-1), // Invalid
        ),
        throwsArgumentError,
      );

      expect(
        () => NutritionRecord(
          startTime: startTime,
          endTime: endTime,
          metadata: metadata,
          calcium: const Mass.grams(100.1), // Invalid > 100g
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = NutritionRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        foodName: 'Chicken with Rice',
        mealType: MealType.lunch,
        energy: energy,
        protein: protein,
        calcium: calcium,
      );

      final newTime = startTime.subtract(const Duration(minutes: 5));
      const newEnergy = Energy.kilocalories(500);
      const newFoodName = 'Different Food';
      const newMealType = MealType.dinner;
      const newProtein = Mass.grams(40);
      const newCalcium = Mass.grams(0.4);

      final updatedRecord = record.copyWith(
        startTime: newTime,
        energy: newEnergy,
        foodName: newFoodName,
        mealType: newMealType,
        protein: newProtein,
        calcium: newCalcium,
      );

      expect(updatedRecord.startTime, newTime);
      expect(updatedRecord.energy, newEnergy);
      expect(updatedRecord.foodName, newFoodName);
      expect(updatedRecord.mealType, newMealType);
      expect(updatedRecord.protein, newProtein);
      expect(updatedRecord.calcium, newCalcium);
      expect(updatedRecord.metadata, metadata); // Unchanged
    });
  });
}
