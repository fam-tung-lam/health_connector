import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietaryVitaminKRecord (Vitamin)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(0.00012); // 120 mcg

    test('can be instantiated with valid parameters', () {
      final record = DietaryVitaminKRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Kale',
        mealType: MealType.lunch,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietaryVitaminKRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietaryVitaminKRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(10.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietaryVitaminKRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Kale',
        mealType: MealType.lunch,
      );

      const newMass = Mass.grams(0.00009); // 90 mcg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Spinach';
      const newMealType = MealType.dinner;

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
      final record1 = DietaryVitaminKRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietaryVitaminKRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietaryVitaminKRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(0.00015),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
