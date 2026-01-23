import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryCalciumRecord (Mineral)', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.3); // 300 mg

    test('can be instantiated with valid parameters', () {
      final record = DietaryCalciumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Milk',
        mealType: MealType.breakfast,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryCalciumRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryCalciumRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(100.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryCalciumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Milk',
        mealType: MealType.breakfast,
      );

      const newMass = Mass.grams(0.4); // 400 mg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Cheese';
      const newMealType = MealType.snack;

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
      final record1 = DietaryCalciumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryCalciumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryCalciumRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.5),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
