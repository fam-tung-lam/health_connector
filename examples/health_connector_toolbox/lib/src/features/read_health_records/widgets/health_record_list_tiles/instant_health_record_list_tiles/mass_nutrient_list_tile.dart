// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show
        MealType,
        Mass,
        NutrientRecord,
        DietaryPantothenicAcidRecord,
        DietaryProteinRecord,
        DietaryTotalCarbohydrateRecord,
        DietaryTotalFatRecord,
        DietarySaturatedFatRecord,
        DietaryMonounsaturatedFatRecord,
        DietaryPolyunsaturatedFatRecord,
        DietaryCholesterolRecord,
        DietaryFiberRecord,
        DietarySugarRecord,
        DietaryCaffeineRecord,
        DietaryCalciumRecord,
        DietaryIronRecord,
        DietaryMagnesiumRecord,
        DietaryManganeseRecord,
        DietaryPhosphorusRecord,
        DietaryPotassiumRecord,
        DietarySeleniumRecord,
        DietarySodiumRecord,
        DietaryZincRecord,
        DietaryVitaminARecord,
        DietaryVitaminB6Record,
        DietaryVitaminB12Record,
        DietaryVitaminCRecord,
        DietaryVitaminDRecord,
        DietaryVitaminERecord,
        DietaryVitaminKRecord,
        DietaryThiaminRecord,
        DietaryRiboflavinRecord,
        DietaryNiacinRecord,
        DietaryFolateRecord,
        DietaryBiotinRecord;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Generic list tile widget for displaying mass-based nutrient records.
///
/// The type parameter [T] should be a nutrient record type that has:
/// - `Mass value` property
/// - `String? foodName` property
/// - `MealType mealType` property
final class MassNutrientListTile<T extends NutrientRecord<Mass>>
    extends StatelessWidget {
  /// Gets the configuration for a mass-based nutrient record type.
  ///
  /// Returns `null` if the type is not registered.
  static _MassNutrientListTileConfig? _getMassNutrientConfig(Type type) {
    return _massNutrientListTileConfigs[type];
  }

  const MassNutrientListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final T record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final config = _getMassNutrientConfig(T);

    // This should never happen at runtime if registry is properly configured
    assert(
      config != null,
      'No configuration found for nutrient type $T. '
      'Please add it to NutrientListTileRegistry.massNutrients',
    );

    if (config == null) {
      // Fallback for release mode - show generic tile
      return InstantHealthRecordTile<T>(
        record: record,
        icon: Icons.fastfood,
        title:
            'Unknown Nutrient: '
            '${(record as dynamic).mass.inGrams.toStringAsFixed(3)} g',
        subtitleBuilder: _buildSubtitle,
        detailRowsBuilder: (r, ctx) => [],
        onDelete: onDelete,
      );
    }

    return InstantHealthRecordTile<T>(
      record: record,
      icon: config.icon,
      title: _buildTitle(config.displayName),
      subtitleBuilder: _buildSubtitle,
      detailRowsBuilder: (r, ctx) => _buildDetailRows(config.displayName, r),
      onDelete: onDelete,
    );
  }

  /// Builds the title displaying the nutrient name and mass values.
  String _buildTitle(String nutrientDisplayName) {
    final mass = (record as dynamic).mass as Mass;
    return '$nutrientDisplayName: '
        '${mass.inGrams.toStringAsFixed(3)} g '
        '(${(mass.inGrams * 1000).toStringAsFixed(1)} mg)';
  }

  /// Builds the subtitle showing time, food name, meal type, and
  /// recording method.
  Widget _buildSubtitle(T rec, BuildContext ctx) {
    final foodName = rec.foodName;
    final mealType = rec.mealType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          '${AppTexts.time}: ${DateFormatter.formatDateTime(rec.time)}',
        ),
        if (foodName != null && foodName.isNotEmpty)
          Text(
            '${AppTexts.food}: $foodName',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
            ),
          ),
        if (mealType != MealType.unknown)
          Text(
            '${AppTexts.meal}: ${mealType.displayName}',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
            ),
          ),
        Text(
          '${AppTexts.recording}: ${rec.metadata.recordingMethod.name}',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(ctx).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Builds detail rows showing mass in grams and milligrams, food name, and
  /// meal type.
  List<Widget> _buildDetailRows(String nutrientDisplayName, T rec) {
    final mass = (rec as dynamic).mass as Mass;
    final foodName = rec.foodName;
    final mealType = rec.mealType;

    return [
      HealthRecordDetailRow(
        label: '$nutrientDisplayName (g)',
        value: mass.inGrams.toStringAsFixed(3),
      ),
      HealthRecordDetailRow(
        label: '$nutrientDisplayName (mg)',
        value: (mass.inGrams * 1000).toStringAsFixed(1),
      ),
      if (foodName != null && foodName.isNotEmpty)
        HealthRecordDetailRow(
          label: AppTexts.foodName,
          value: foodName,
        ),
      if (mealType != MealType.unknown)
        HealthRecordDetailRow(
          label: AppTexts.mealType,
          value: mealType.displayName,
        ),
    ];
  }

  /// Configuration for mass-based nutrient records.
  static const Map<Type, _MassNutrientListTileConfig>
  _massNutrientListTileConfigs = {
    // Macronutrients
    DietaryProteinRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.protein,
      icon: AppIcons.fastfood,
    ),
    DietaryTotalCarbohydrateRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.totalCarbohydrate,
      icon: AppIcons.fastfood,
    ),
    DietaryTotalFatRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.totalFat,
      icon: AppIcons.fastfood,
    ),
    DietarySaturatedFatRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.saturatedFat,
      icon: AppIcons.fastfood,
    ),
    DietaryMonounsaturatedFatRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.monounsaturatedFat,
      icon: AppIcons.fastfood,
    ),
    DietaryPolyunsaturatedFatRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.polyunsaturatedFat,
      icon: AppIcons.fastfood,
    ),
    DietaryCholesterolRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.cholesterol,
      icon: AppIcons.fastfood,
    ),
    DietaryFiberRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.dietaryFiber,
      icon: AppIcons.fastfood,
    ),
    DietarySugarRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.sugar,
      icon: AppIcons.fastfood,
    ),
    DietaryCaffeineRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.caffeine,
      icon: AppIcons.fastfood,
    ),

    // Mineral nutrients
    DietaryCalciumRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.calcium,
      icon: AppIcons.fastfood,
    ),
    DietaryIronRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.iron,
      icon: AppIcons.fastfood,
    ),
    DietaryMagnesiumRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.magnesium,
      icon: AppIcons.fastfood,
    ),
    DietaryManganeseRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.manganese,
      icon: AppIcons.fastfood,
    ),
    DietaryPhosphorusRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.phosphorus,
      icon: AppIcons.fastfood,
    ),
    DietaryPotassiumRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.potassium,
      icon: AppIcons.fastfood,
    ),
    DietarySeleniumRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.selenium,
      icon: AppIcons.fastfood,
    ),
    DietarySodiumRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.sodium,
      icon: AppIcons.fastfood,
    ),
    DietaryZincRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.zinc,
      icon: AppIcons.fastfood,
    ),

    // Vitamin nutrients
    DietaryVitaminARecord: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminA,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminB6Record: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminB6,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminB12Record: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminB12,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminCRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminC,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminDRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminD,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminERecord: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminE,
      icon: AppIcons.fastfood,
    ),
    DietaryVitaminKRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.vitaminK,
      icon: AppIcons.fastfood,
    ),
    DietaryThiaminRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.thiamin,
      icon: AppIcons.fastfood,
    ),
    DietaryRiboflavinRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.riboflavin,
      icon: AppIcons.fastfood,
    ),
    DietaryNiacinRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.niacin,
      icon: AppIcons.fastfood,
    ),
    DietaryFolateRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.folate,
      icon: AppIcons.fastfood,
    ),
    DietaryBiotinRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.biotin,
      icon: AppIcons.fastfood,
    ),
    DietaryPantothenicAcidRecord: _MassNutrientListTileConfig(
      displayName: AppTexts.pantothenicAcid,
      icon: AppIcons.fastfood,
    ),
  };
}

/// Configuration for a nutrient list tile.
@immutable
final class _MassNutrientListTileConfig {
  const _MassNutrientListTileConfig({
    required this.displayName,
    required this.icon,
  });

  /// The display name for the nutrient (e.g., "Protein", "Calcium").
  final String displayName;

  /// The icon to display for this nutrient.
  final IconData icon;
}
