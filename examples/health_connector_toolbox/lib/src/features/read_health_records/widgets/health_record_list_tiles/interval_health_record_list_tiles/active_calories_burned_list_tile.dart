import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying active calories burned record tiles.
final class ActiveCaloriesBurnedTile extends StatelessWidget {
  const ActiveCaloriesBurnedTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final ActiveCaloriesBurnedRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<ActiveCaloriesBurnedRecord>(
      record: record,
      icon: AppIcons.localFireDepartment,
      title: '${record.energy.inKilocalories.toStringAsFixed(0)} kcal (Active)',
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
