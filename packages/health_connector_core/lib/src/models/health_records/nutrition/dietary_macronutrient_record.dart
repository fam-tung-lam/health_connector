part of '../health_record.dart';

/// Base class for macronutrient health records.
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class DietaryMacronutrientRecord extends NutrientRecord<Mass> {
  /// Minimum valid macronutrient mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid macronutrient mass (1,000.0 g).
  static const Mass maxMass = Mass.grams(1000.0);

  DietaryMacronutrientRecord({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  }) {
    require(
      condition: mass >= minMass && mass <= maxMass,
      value: mass,
      name: 'mass',
      message:
          'Macronutrient mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(1)} g.',
    );
  }

  /// The mass of the nutrient.
  final Mass mass;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is DietaryMacronutrientRecord &&
          (mass.inGrams - other.mass.inGrams).abs() < 1e-6;

  @override
  int get hashCode => super.hashCode ^ mass.hashCode;
}
