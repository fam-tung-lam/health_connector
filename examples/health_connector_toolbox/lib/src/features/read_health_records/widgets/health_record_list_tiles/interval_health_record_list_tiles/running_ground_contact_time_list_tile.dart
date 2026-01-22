import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/simple_interval_measurement_list_tile.dart';

/// Widget for displaying running ground contact time record tiles.
final class RunningGroundContactTimeRecordListTile extends StatelessWidget {
  const RunningGroundContactTimeRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final RunningGroundContactTimeRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SimpleIntervalMeasurementListTile<RunningGroundContactTimeRecord>(
      record: record,
      icon: AppIcons.runCircle,
      titleBuilder: (r) =>
          '${r.groundContactTime.inMilliseconds.toStringAsFixed(0)} ms',
      valueExtractor: (r) => r.groundContactTime,
      onDelete: onDelete,
    );
  }
}
