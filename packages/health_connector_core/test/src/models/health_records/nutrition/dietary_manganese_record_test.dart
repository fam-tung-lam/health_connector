import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryManganeseRecord (Mineral)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.0023); // 2.3 mg

    test('can be instantiated with valid parameters', () {
      final record = DietaryManganeseRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Pineapple',
        mealType: MealType.snack,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryManganeseRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryManganeseRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(100.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryManganeseRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Pineapple',
        mealType: MealType.snack,
      );

      const newMass = Mass.grams(0.0018); // 1.8 mg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Oatmeal';
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
      final record1 = DietaryManganeseRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryManganeseRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryManganeseRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.0025),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
