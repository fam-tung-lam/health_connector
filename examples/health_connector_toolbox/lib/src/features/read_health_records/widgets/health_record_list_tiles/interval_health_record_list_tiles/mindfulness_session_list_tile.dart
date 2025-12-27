import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/mindfulness_session_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying mindfulness session record tiles.
final class MindfulnessSessionListTile extends StatelessWidget {
  const MindfulnessSessionListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final MindfulnessSessionRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final title = (record.title?.isNotEmpty ?? false)
        ? record.title!
        : record.sessionType.displayName;

    final hasNotes = record.notes?.isNotEmpty ?? false;

    return IntervalHealthRecordTile<MindfulnessSessionRecord>(
      record: record,
      icon: AppIcons.selfImprovement,
      title: title,
      subtitleBuilder: (r, ctx) {
        final baseSubtitle = HealthRecordListTileSubtitle.interval(
          startTime: r.startTime,
          endTime: r.endTime,
          recordingMethod: r.metadata.recordingMethod.name,
        );

        if (!hasNotes) {
          return baseSubtitle;
        }

        // Add notes row if present
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            baseSubtitle,
            const SizedBox(height: 4),
            Text(
              '${AppTexts.notes}: ${r.notes}',
              style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: 'Session Type',
          value: r.sessionType.displayName,
        ),
        if (r.title?.isNotEmpty ?? false)
          HealthRecordDetailRow(
            label: 'Title',
            value: r.title,
          ),
        if (r.notes?.isNotEmpty ?? false)
          HealthRecordDetailRow(
            label: AppTexts.notes,
            value: r.notes,
          ),
      ],
      onDelete: onDelete,
    );
  }
}
