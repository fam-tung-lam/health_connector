import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying floors climbed record tiles.
final class FloorsClimbedTile extends StatelessWidget {
  const FloorsClimbedTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final FloorsClimbedRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<FloorsClimbedRecord>(
      record: record,
      icon: AppIcons.stairs,
      title: '${record.count.value} floors',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
