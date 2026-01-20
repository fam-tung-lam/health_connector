import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// List tile for displaying an irregular heart rhythm event record.
class IrregularHeartRhythmEventRecordListTile extends StatelessWidget {
  /// Creates an irregular heart rhythm event record list tile.
  const IrregularHeartRhythmEventRecordListTile({
    required this.record,
    super.key,
  });

  /// The irregular heart rhythm event record to display.
  final IrregularHeartRhythmEventRecord record;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<IrregularHeartRhythmEventRecord>(
      record: record,
      icon: Icons.monitor_heart,
      title: 'Irregular Heart Rhythm Event',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
    );
  }
}
