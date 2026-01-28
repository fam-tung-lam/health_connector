import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/series_health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/heartbeat_series_record_samples_list.dart';

/// Widget for displaying heartbeat series record tiles.
final class HeartbeatSeriesTile extends StatelessWidget {
  const HeartbeatSeriesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HeartbeatSeriesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordTile<HeartbeatSeriesRecord, HeartbeatSample>(
      record: record,
      icon: AppIcons.favorite,
      title: 'Heartbeat Series',
      subtitleBuilder: (r, ctx) => Text(
        '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
        style: Theme.of(ctx).textTheme.bodySmall,
      ),
      detailRowsBuilder: (r, ctx) => [],
      samplesBuilder: (samples, ctx) =>
          HeartbeatSeriesRecordSampleList(samples: samples),
      onDelete: onDelete,
    );
  }
}
