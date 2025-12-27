import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show SleepStage;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sleep_stage_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of sleep stage samples.
///
/// Shows each sleep stage with its type, time range, and duration in a clean
/// list format.
@immutable
final class SleepSessionRecordSleepStagesList extends StatelessWidget {
  const SleepSessionRecordSleepStagesList({
    required this.stages,
    super.key,
  });

  /// The list of sleep stages to display.
  final List<SleepStage> stages;

  /// Formats a duration as a human-readable string (e.g., "2h 30m").
  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<SleepStage>(
      title: AppTexts.sleepStages,
      samples: stages,
      emptyMessage: AppTexts.noSleepStagesAvailable,
      itemBuilder: (stage, index) {
        final stageTypeName = stage.stageType.displayName;
        final duration = _formatDuration(stage.duration);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stageTypeName,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              '${DateFormatter.formatDateTime(stage.startTime)} - '
              '${DateFormatter.formatDateTime(stage.endTime)} '
              '($duration)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
