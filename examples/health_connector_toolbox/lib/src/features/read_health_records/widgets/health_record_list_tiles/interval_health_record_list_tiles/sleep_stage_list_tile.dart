import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sleep_stage_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying sleep stage record tiles.
final class SleepStageTile extends StatelessWidget {
  const SleepStageTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final SleepStageRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final duration = record.duration;
    return IntervalHealthRecordTile<SleepStageRecord>(
      record: record,
      icon: AppIcons.bedtime,
      title: '${record.stageType.displayName} (${duration.inMinutes}m)',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.stageType,
          value: r.stageType.displayName,
        ),
        HealthRecordDetailRow(
          label: AppTexts.duration,
          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
        ),
      ],
      onDelete: onDelete,
    );
  }
}
