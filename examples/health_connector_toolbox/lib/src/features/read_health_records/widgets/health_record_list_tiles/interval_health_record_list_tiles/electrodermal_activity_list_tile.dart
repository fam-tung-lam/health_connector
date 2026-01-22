import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying electrodermal activity record tiles.
final class ElectrodermalActivityTile extends StatelessWidget {
  const ElectrodermalActivityTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final ElectrodermalActivityRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<ElectrodermalActivityRecord>(
      record: record,
      icon: AppIcons.sensors,
      title: '${record.conductance.value.toStringAsFixed(2)} μS',
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
