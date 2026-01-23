import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryPantothenicAcidRecord (Vitamin)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.005); // 5 mg

    test('can be instantiated with valid parameters', () {
      final record = DietaryPantothenicAcidRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Mushrooms',
        mealType: MealType.lunch,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryPantothenicAcidRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryPantothenicAcidRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(10.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryPantothenicAcidRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Mushrooms',
        mealType: MealType.lunch,
      );

      const newMass = Mass.grams(0.003); // 3 mg
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
      expect(updatedRecord.time, newTime.toUtc());
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.foodName, newFoodName);
      expect(updatedRecord.mealType, newMealType);
    });

    test('equality works correctly', () {
      final record1 = DietaryPantothenicAcidRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryPantothenicAcidRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryPantothenicAcidRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.007),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
