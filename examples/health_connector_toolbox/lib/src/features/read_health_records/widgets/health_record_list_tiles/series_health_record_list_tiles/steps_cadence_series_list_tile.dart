import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/series_health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/steps_cadence_series_record_samples_list.dart';

/// Widget for displaying steps cadence series record tiles.
@immutable
final class StepsCadenceSeriesTile extends StatelessWidget {
  const StepsCadenceSeriesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final StepsCadenceSeriesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordTile<StepsCadenceSeriesRecord, StepsCadenceSample>(
      record: record,
      icon: AppIcons.speed,
      title: '${AppTexts.stepsCadence} Series',
      subtitleBuilder: (r, ctx) {
        final total = r.samples.fold(
          0.0,
          (sum, e) => sum + e.cadence.inPerMinute,
        );
        final average = r.samples.isEmpty ? 0.0 : total / r.samples.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
            Text(
              '${AppTexts.average}: ${average.toStringAsFixed(1)} '
              '${AppTexts.stepsPerMinute}',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
            Text(
              '${r.samples.length} ${AppTexts.stepsCadence} '
              '${AppTexts.samples}',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [],
      samplesBuilder: (samples, ctx) =>
          StepsCadenceSeriesRecordSamplesList(samples: samples),
      onDelete: onDelete,
    );
  }
}
