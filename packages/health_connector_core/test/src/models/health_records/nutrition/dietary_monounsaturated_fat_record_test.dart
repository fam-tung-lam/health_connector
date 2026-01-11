import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryMonounsaturatedFatRecord (Macronutrient)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(15.0); // 15 g

    test('can be instantiated with valid parameters', () {
      final record = DietaryMonounsaturatedFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Olive oil',
        mealType: MealType.lunch,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryMonounsaturatedFatRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryMonounsaturatedFatRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(1000.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryMonounsaturatedFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Olive oil',
        mealType: MealType.lunch,
      );

      const newMass = Mass.grams(12.0); // 12 g
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Avocado';
      const newMealType = MealType.breakfast;

      final updatedRecord = record.copyWith(
        mass: newMass,
        time: newTime,
        metadata: newMetadata,
        foodName: newFoodName,
        mealType: newMealType,
      );

      expect(updatedRecord.mass, newMass);
      expect(updatedRecord.time, newTime);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.foodName, newFoodName);
      expect(updatedRecord.mealType, newMealType);
    });

    test('equality works correctly', () {
      final record1 = DietaryMonounsaturatedFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryMonounsaturatedFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryMonounsaturatedFatRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(18.0),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
