import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying hydration record tiles.
final class HydrationTile extends StatelessWidget {
  const HydrationTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HydrationRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<HydrationRecord>(
      record: record,
      icon: AppIcons.volume,
      title: '${record.volume.inLiters.toStringAsFixed(2)} L',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
      ],
      onDelete: onDelete,
    );
  }
}
