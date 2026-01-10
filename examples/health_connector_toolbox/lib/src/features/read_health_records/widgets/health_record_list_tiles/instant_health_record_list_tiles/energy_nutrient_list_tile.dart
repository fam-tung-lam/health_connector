import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show DietaryEnergyConsumedRecord, MealType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/measurement_unit_display.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// List tile widget for displaying energy nutrient records.
///
/// Energy nutrients use Energy units (kilocalories/calories) instead of
/// Mass units, so they require a separate implementation from mass-based
/// nutrients.
final class EnergyNutrientListTile extends StatelessWidget {
  const EnergyNutrientListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final DietaryEnergyConsumedRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<DietaryEnergyConsumedRecord>(
      record: record,
      icon: AppIcons.localFireDepartment,
      title: _buildTitle(),
      subtitleBuilder: _buildSubtitle,
      detailRowsBuilder: _buildDetailRows,
      onDelete: onDelete,
    );
  }

  /// Builds the title displaying energy in kilocalories and calories.
  String _buildTitle() {
    return '${record.energy.inKilocalories.toStringAsFixed(2)} kcal '
        '(${record.energy.inCalories.toStringAsFixed(0)} cal)';
  }

  /// Builds the subtitle showing time, food name, meal type, and
  /// recording method.
  Widget _buildSubtitle(DietaryEnergyConsumedRecord rec, BuildContext ctx) {
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

  /// Builds detail rows showing energy value, food name, and meal type.
  List<Widget> _buildDetailRows(
    DietaryEnergyConsumedRecord rec,
    BuildContext ctx,
  ) {
    final foodName = rec.foodName;
    final mealType = rec.mealType;

    return [
      const HealthRecordDetailRow(
        label: AppTexts.value,
        value: '',
      ),
      MeasurementUnitDisplay(unit: rec.energy),
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
}
