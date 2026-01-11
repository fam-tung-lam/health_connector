part of '../health_record.dart';

/// Base class for mineral nutrient health records.
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class DietaryMineralRecord extends NutrientRecord<Mass> {
  /// Minimum valid mineral mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid mineral mass (100.0 g).
  static const Mass maxMass = Mass.grams(100.0);

  DietaryMineralRecord({
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
          'Mineral mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(3)} g.',
    );
  }

  /// The mineral content of the nutrient.
  final Mass mass;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is DietaryMineralRecord &&
          (mass.inGrams - other.mass.inGrams).abs() < 1e-6;

  @override
  int get hashCode => super.hashCode ^ mass.hashCode;
}
