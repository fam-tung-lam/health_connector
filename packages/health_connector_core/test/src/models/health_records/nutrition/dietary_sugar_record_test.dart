import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietarySugarRecord (Macronutrient)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(50.0); // 50 g

    test('can be instantiated with valid parameters', () {
      final record = DietarySugarRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Soda',
        mealType: MealType.snack,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietarySugarRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietarySugarRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(1000.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietarySugarRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Soda',
        mealType: MealType.snack,
      );

      const newMass = Mass.grams(25.0); // 25 g
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Apple';
      const newMealType = MealType.breakfast;

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
      final record1 = DietarySugarRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietarySugarRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietarySugarRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(30.0),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
