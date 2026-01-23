import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryProteinRecord (Macronutrient)', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(30);

    test('can be instantiated with valid parameters', () {
      final record = DietaryProteinRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Steak',
        mealType: MealType.dinner,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
      expect(record.foodName, 'Steak');
      expect(record.mealType, MealType.dinner);
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryProteinRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryProteinRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(1001),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryProteinRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Steak',
        mealType: MealType.dinner,
      );

      const newMass = Mass.grams(40);
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Chicken';
      const newMealType = MealType.lunch;

      final updatedRecord = record.copyWith(
        mass: newMass,
        time: newTime,
        metadata: newMetadata,
        foodName: newFoodName,
        mealType: newMealType,
      );

      expect(updatedRecord.mass, newMass);
      expect(updatedRecord.time, newTime.toUtc());
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.foodName, newFoodName);
      expect(updatedRecord.mealType, newMealType);
    });

    test('equality works correctly', () {
      final record1 = DietaryProteinRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryProteinRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryProteinRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(40),
      );

      expect(record1 == record2, isTrue);
      expect(record1.hashCode, equals(record2.hashCode));
      expect(record1 == record3, isFalse);
    });
  });
}
