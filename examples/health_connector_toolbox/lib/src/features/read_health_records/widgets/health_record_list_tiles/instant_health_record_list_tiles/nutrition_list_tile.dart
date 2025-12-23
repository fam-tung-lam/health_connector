import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/measurement_unit_display.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying nutrition record tiles.
final class NutritionTile extends StatelessWidget {
  const NutritionTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final NutritionRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<NutritionRecord>(
      record: record,
      icon: AppIcons.fastfood,
      title: _getTitle(record),
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
          if (r.mealType != MealType.unknown)
            Text(
              '${AppTexts.mealType}: ${r.mealType.name}',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
        ],
      ),
      detailRowsBuilder: (r, ctx) {
        final rows = <Widget>[];

        // Add standard nutrients if present
        if (r.energy != null) {
          rows.add(const HealthRecordDetailRow(label: 'Energy', value: ''));
          rows.add(MeasurementUnitDisplay(unit: r.energy!));
        }

        if (r.totalFat != null) {
          rows.add(const HealthRecordDetailRow(label: 'Total Fat', value: ''));
          rows.add(MeasurementUnitDisplay(unit: r.totalFat!));
        }

        if (r.protein != null) {
          rows.add(const HealthRecordDetailRow(label: 'Protein', value: ''));
          rows.add(MeasurementUnitDisplay(unit: r.protein!));
        }

        if (r.totalCarbohydrate != null) {
          rows.add(const HealthRecordDetailRow(label: 'Carbs', value: ''));
          rows.add(MeasurementUnitDisplay(unit: r.totalCarbohydrate!));
        }

        return rows;
      },
      onDelete: onDelete,
    );
  }

  String _getTitle(NutritionRecord record) {
    if (record.foodName != null && record.foodName!.isNotEmpty) {
      return record.foodName!;
    }
    return 'Nutrition Record';
  }
}
