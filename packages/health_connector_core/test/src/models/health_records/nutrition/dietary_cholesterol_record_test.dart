import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryCholesterolRecord (Macronutrient)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.186); // 186 mg

    test('can be instantiated with valid parameters', () {
      final record = DietaryCholesterolRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Egg',
        mealType: MealType.breakfast,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryCholesterolRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryCholesterolRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(1000.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryCholesterolRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Egg',
        mealType: MealType.breakfast,
      );

      const newMass = Mass.grams(0.150); // 150 mg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Shrimp';
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
      final record1 = DietaryCholesterolRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryCholesterolRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryCholesterolRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.200),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
