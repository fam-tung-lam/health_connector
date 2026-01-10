import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/series_health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/speed_series_record_samples_list.dart';

/// Widget for displaying speed series record tiles.
final class SpeedSeriesTile extends StatelessWidget {
  const SpeedSeriesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final SpeedSeriesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordTile<SpeedSeriesRecord, SpeedSample>(
      record: record,
      icon: AppIcons.speed,
      title: 'Speed Series',
      subtitleBuilder: (r, ctx) => Text(
        '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
        style: Theme.of(ctx).textTheme.bodySmall,
      ),
      detailRowsBuilder: (r, ctx) => [],
      samplesBuilder: (samples, ctx) =>
          SpeedSeriesRecordSamplesList(samples: samples),
      onDelete: onDelete,
    );
  }
}
