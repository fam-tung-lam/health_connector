import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying menstruation period record tiles.
final class MenstruationPeriodRecordListTile extends StatelessWidget {
  const MenstruationPeriodRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final MenstruationPeriodRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<MenstruationPeriodRecord>(
      record: record,
      icon: Icons.water_drop,
      title: AppTexts.menstruationPeriod,
      subtitleBuilder: (r, ctx) {
        return HealthRecordListTileSubtitle.interval(
          startTime: r.startTime,
          endTime: r.endTime,
          recordingMethod: r.metadata.recordingMethod.name,
        );
      },
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
