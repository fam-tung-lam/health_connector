import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/simple_interval_measurement_list_tile.dart';

/// Widget for displaying running stride length record tiles.
final class RunningStrideLengthRecordListTile extends StatelessWidget {
  const RunningStrideLengthRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final RunningStrideLengthRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SimpleIntervalMeasurementListTile<RunningStrideLengthRecord>(
      record: record,
      icon: AppIcons.runCircle,
      titleBuilder: (r) => '${r.strideLength.inMeters.toStringAsFixed(2)} m',
      valueExtractor: (r) => r.strideLength,
      onDelete: onDelete,
    );
  }
}
