import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/device_placement_side_ui_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying walking double support percentage record tiles.
final class WalkingDoubleSupportPercentageRecordListTile
    extends StatelessWidget {
  const WalkingDoubleSupportPercentageRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final WalkingDoubleSupportPercentageRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<WalkingDoubleSupportPercentageRecord>(
      record: record,
      icon: AppIcons.directionsWalk,
      title: AppTexts.walkingDoubleSupportPercentage,
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        _DetailRow(
          label: AppTexts.value,
          value: '${r.percentage.asWhole.toStringAsFixed(1)} %',
        ),
        _DetailRow(
          label: AppTexts.deviceLabel,
          value: r.devicePlacementSide.displayName,
        ),
      ],
      onDelete: onDelete,
    );
  }
}

/// Helper widget for detail rows.
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
