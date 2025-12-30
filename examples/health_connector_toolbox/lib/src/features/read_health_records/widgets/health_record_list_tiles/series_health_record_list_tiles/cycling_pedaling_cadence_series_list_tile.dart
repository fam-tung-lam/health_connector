import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/cycling_pedaling_cadence_series_record_samples_list.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/series_health_record_list_tile.dart';

/// Widget for displaying cycling pedaling cadence series record tiles.
@immutable
final class CyclingPedalingCadenceSeriesTile extends StatelessWidget {
  const CyclingPedalingCadenceSeriesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final CyclingPedalingCadenceSeriesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordTile<
      CyclingPedalingCadenceSeriesRecord,
      CyclingPedalingCadenceMeasurement
    >(
      record: record,
      icon: AppIcons.speed,
      title: '${AppTexts.cyclingPedalingCadence} Series',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
          Text(
            '${AppTexts.average}: ${r.averageRpm.value} ${AppTexts.rpm}',
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
          Text(
            '${r.samples.length} ${AppTexts.cyclingPedalingCadenceSamples}',
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [],
      samplesBuilder: (samples, ctx) =>
          CyclingPedalingCadenceSeriesRecordSamplesList(samples: samples),
      onDelete: onDelete,
    );
  }
}
