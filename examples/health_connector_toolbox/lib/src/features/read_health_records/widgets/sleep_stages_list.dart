import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show SleepStage, SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_format_utils.dart';

/// Widget that displays a list of sleep stage samples.
///
/// Shows each sleep stage with its type, time range, and duration in a clean
/// list format.
@immutable
final class SleepStagesList extends StatelessWidget {
  const SleepStagesList({
    required this.stages,
    super.key,
  });

  /// The list of sleep stages to display.
  final List<SleepStage> stages;

  /// Maps a [SleepStageType] to its display string.
  static String _getStageTypeDisplayName(SleepStageType type) {
    return switch (type) {
      SleepStageType.unknown => AppTexts.sleepStageUnknown,
      SleepStageType.awake => AppTexts.sleepStageAwake,
      SleepStageType.sleeping => AppTexts.sleepStageSleeping,
      SleepStageType.outOfBed => AppTexts.sleepStageOutOfBed,
      SleepStageType.light => AppTexts.sleepStageLight,
      SleepStageType.deep => AppTexts.sleepStageDeep,
      SleepStageType.rem => AppTexts.sleepStageRem,
      SleepStageType.inBed => AppTexts.sleepStageInBed,
    };
  }

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
    if (stages.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No sleep stages available',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppTexts.sleepStages,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...stages.asMap().entries.map((entry) {
          final index = entry.key;
          final stage = entry.value;
          final stageTypeName = _getStageTypeDisplayName(stage.stageType);
          final duration = _formatDuration(stage.duration);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stageTypeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${DateFormatUtils.formatDateTime(stage.startTime)} - '
                        '${DateFormatUtils.formatDateTime(stage.endTime)} '
                        '($duration)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
