import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying distance record tiles.
final class DistanceTile extends StatelessWidget {
  const DistanceTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final DistanceRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<DistanceRecord>(
      record: record,
      icon: AppIcons.straighten,
      title: '${record.distance.inMeters.toStringAsFixed(0)} m',
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
