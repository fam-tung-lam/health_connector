import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryVitaminARecord (Vitamin)', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.0008); // 800 mcg

    test('can be instantiated with valid parameters', () {
      final record = DietaryVitaminARecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Carrot',
        mealType: MealType.snack,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryVitaminARecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryVitaminARecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(10.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryVitaminARecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Carrot',
        mealType: MealType.snack,
      );

      const newMass = Mass.grams(0.0009); // 900 mcg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Pumpkin';
      const newMealType = MealType.dinner;

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
      final record1 = DietaryVitaminARecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryVitaminARecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryVitaminARecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.001),
      );

      expect(record1 == record2, isTrue);
      expect(record1.hashCode, equals(record2.hashCode));
      expect(record1 == record3, isFalse);
    });
  });
}
