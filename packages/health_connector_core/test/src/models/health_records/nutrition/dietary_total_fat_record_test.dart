import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryTotalFatRecord (Macronutrient)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(65.0); // 65 g

    test('can be instantiated with valid parameters', () {
      final record = DietaryTotalFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Nuts',
        mealType: MealType.snack,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryTotalFatRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryTotalFatRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(1000.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryTotalFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Nuts',
        mealType: MealType.snack,
      );

      const newMass = Mass.grams(50.0); // 50 g
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Cheese';
      const newMealType = MealType.lunch;

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
      final record1 = DietaryTotalFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryTotalFatRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryTotalFatRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(80.0),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
