import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying blood glucose record tiles.
final class BloodGlucoseTile extends StatelessWidget {
  const BloodGlucoseTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final BloodGlucoseRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<BloodGlucoseRecord>(
      record: record,
      icon: AppIcons.bloodGlucose,
      title: '${record.glucoseLevel.inMilligramsPerDeciliter} mg/dL',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.relationToMeal,
          value: r.relationToMeal.name,
        ),
        HealthRecordDetailRow(
          label: AppTexts.mealType,
          value: r.mealType.name,
        ),
        HealthRecordDetailRow(
          label: AppTexts.specimenSource,
          value: r.specimenSource.name,
        ),
      ],
      onDelete: onDelete,
    );
  }
}
