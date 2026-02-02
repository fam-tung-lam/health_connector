import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_segment_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_state_transition_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/utils/show_exercise_route_dialog.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';
import 'package:intl/intl.dart';

/// Widget for displaying exercise session record tiles.
final class ExerciseSessionTile extends StatelessWidget {
  const ExerciseSessionTile({
    required this.notifier,
    required this.record,
    required this.onDelete,
    super.key,
  });

  final ReadHealthRecordsChangeNotifier notifier;
  final ExerciseSessionRecord record;
  final VoidCallback onDelete;

  /// Formats exercise type name for display.
  /// (capitalizes first letter of each word).
  String _formatExerciseType(ExerciseType type) {
    final name = type.name;
    // Split by capital letters and join with spaces
    final words = name
        .replaceAllMapped(
          RegExp('([A-Z])'),
          (match) => ' ${match.group(0)}',
        )
        .trim();
    // Capitalize first letter
    return words.isEmpty ? name : words[0].toUpperCase() + words.substring(1);
  }

  /// Formats event summary for display.
  String _formatEventSummary(List<ExerciseSessionEvent> events) {
    if (events.isEmpty) {
      return '';
    }

    final laps = events.whereType<ExerciseSessionLapEvent>().length;
    final segments = events.whereType<ExerciseSessionSegmentEvent>().length;
    final transitions = events
        .whereType<ExerciseSessionStateTransitionEvent>()
        .length;
    final markers = events.whereType<ExerciseSessionMarkerEvent>().length;

    final parts = <String>[];
    if (laps > 0) {
      parts.add(
        '$laps ${AppTexts.lapEvent.toLowerCase()}(s)',
      );
    }
    if (segments > 0) {
      parts.add(
        '$segments ${AppTexts.segmentEvent.toLowerCase()}(s)',
      );
    }
    if (transitions > 0) {
      parts.add(
        '$transitions ${AppTexts.stateTransitionEvent.toLowerCase()}(s)',
      );
    }
    if (markers > 0) {
      parts.add(
        '$markers ${AppTexts.markerEvent.toLowerCase()}(s)',
      );
    }

    return parts.join(', ');
  }

  /// Formats a single event for display.
  String _formatEvent(ExerciseSessionEvent event) {
    final timeFormat = DateFormat('HH:mm:ss');
    return switch (event) {
      ExerciseSessionInstantEvent(:final time) => switch (event) {
        ExerciseSessionStateTransitionEvent(:final type) =>
          '${AppTexts.stateTransitionEvent}: ${type.displayName} '
              '(${timeFormat.format(time)})',
        ExerciseSessionMarkerEvent() =>
          '${AppTexts.markerEvent} (${timeFormat.format(time)})',
      },
      ExerciseSessionIntervalEvent(:final startTime, :final endTime) =>
        switch (event) {
          ExerciseSessionLapEvent(:final distance) => () {
            final duration = endTime.difference(startTime);
            final durationStr =
                '${duration.inMinutes}m ${duration.inSeconds % 60}s';
            final startTimeStr = timeFormat.format(startTime);
            final endTimeStr = timeFormat.format(endTime);
            return distance != null
                ? '${AppTexts.lapEvent}: '
                      '${distance.inMeters.toStringAsFixed(1)} '
                      '${AppTexts.metersAbbr} '
                      '($startTimeStr - $endTimeStr, $durationStr)'
                : '${AppTexts.lapEvent} '
                      '($startTimeStr - $endTimeStr, $durationStr)';
          }(),
          ExerciseSessionSegmentEvent(
            :final segmentType,
            :final repetitions,
          ) =>
            () {
              final duration = endTime.difference(startTime);
              final durationStr =
                  '${duration.inMinutes}m ${duration.inSeconds % 60}s';
              final startTimeStr = timeFormat.format(startTime);
              final endTimeStr = timeFormat.format(endTime);
              return '${AppTexts.segmentEvent}: '
                  '${segmentType.displayName}${repetitions != null ? " "
                            "($repetitions "
                            "${AppTexts.repetitions.toLowerCase()})" : ""} '
                  '($startTimeStr - $endTimeStr, $durationStr)';
            }(),
        },
    };
  }

  @override
  Widget build(BuildContext context) {
    final title = (record.title?.isNotEmpty ?? false)
        ? record.title!
        : _formatExerciseType(record.exerciseType);

    final hasNotes = record.notes?.isNotEmpty ?? false;
    final hasEvents = record.events.isNotEmpty;
    final eventSummary = hasEvents ? _formatEventSummary(record.events) : '';

    return IntervalHealthRecordTile<ExerciseSessionRecord>(
      record: record,
      icon: AppIcons.fitnessCenter,
      title: title,
      actions: [
        IconButton(
          icon: Icon(
            AppIcons.route,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          tooltip: AppTexts.loadRoute,
          onPressed: () => _onReadRoute(context),
          visualDensity: VisualDensity.compact,
        ),
      ],
      subtitleBuilder: (r, ctx) {
        final baseSubtitle = HealthRecordListTileSubtitle.interval(
          startTime: r.startTime,
          endTime: r.endTime,
          recordingMethod: r.metadata.recordingMethod.name,
        );

        final additionalInfo = <Widget>[];

        if (hasNotes) {
          additionalInfo.add(
            Text(
              '${AppTexts.notes}: ${r.notes}',
              style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (hasEvents) {
          additionalInfo.add(
            Text(
              '${AppTexts.events}: $eventSummary',
              style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (additionalInfo.isEmpty) {
          return baseSubtitle;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            baseSubtitle,
            const SizedBox(height: 4),
            ...additionalInfo,
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: 'Exercise Type',
          value: r.exerciseType.name,
        ),
        if (r.title?.isNotEmpty ?? false)
          HealthRecordDetailRow(
            label: 'Title',
            value: r.title,
          ),
        if (r.notes?.isNotEmpty ?? false)
          HealthRecordDetailRow(
            label: AppTexts.notes,
            value: r.notes,
          ),
        if (r.events.isNotEmpty) ...[
          HealthRecordDetailRow(
            label: AppTexts.eventCount,
            value: '${r.events.length}',
          ),
          const SizedBox(height: 8),
          Text(
            AppTexts.events,
            style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          ...r.events.map(
            (event) => Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              child: Text(
                _formatEvent(event),
                style: Theme.of(ctx).textTheme.bodySmall,
              ),
            ),
          ),
        ],
        const SizedBox(height: 8),
        const HealthRecordDetailRow(
          label: AppTexts.exerciseRoute,
          value: 'Use readExerciseRoute() to load',
        ),
      ],
      onDelete: onDelete,
    );
  }

  Future<void> _onReadRoute(BuildContext context) async {
    try {
      final route = await notifier.readExerciseRoute(record.id);
      if (!context.mounted) {
        return;
      }

      if (route == null) {
        showAppSnackBar(
          context,
          SnackBarType.info,
          AppTexts.noRouteFound,
        );
      } else {
        await showExerciseRouteDialog(context, route: route);
      }
    } on HealthConnectorException catch (e) {
      if (!context.mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.error,
        e.message,
      );
    }
  }
}
