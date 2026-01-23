import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DietarySodiumRecord (Mineral)', () {
    final now = DateTime.now();
    final metadata = Metadata.manualEntry();
    const validMass = Mass.grams(2.3); // 2300 mg

    test('can be instantiated with valid parameters', () {
      final record = DietarySodiumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Canned soup',
        mealType: MealType.lunch,
      );

      expect(record.time, now.toUtc());
      expect(record.metadata, metadata);
      expect(record.mass, equals(validMass));
    });

    test('throws ArgumentError when mass is below minMass', () {
      expect(
        () => DietarySodiumRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(-0.1),
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when mass is above maxMass', () {
      expect(
        () => DietarySodiumRecord(
          time: now,
          metadata: metadata,
          mass: const Mass.grams(100.1),
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = DietarySodiumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
        foodName: 'Canned soup',
        mealType: MealType.lunch,
      );

      const newMass = Mass.grams(1.5); // 1500 mg
      final newTime = now.add(const Duration(minutes: 5));
      final newMetadata = Metadata.manualEntry();
      const newFoodName = 'Bread';
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
      final record1 = DietarySodiumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record2 = DietarySodiumRecord(
        time: now,
        metadata: metadata,
        mass: validMass,
      );

      final record3 = DietarySodiumRecord(
        time: now,
        metadata: metadata,
        mass: const Mass.grams(3.0),
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
