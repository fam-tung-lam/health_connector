import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';

/// Common subtitle widget for health record tiles.
///
/// Displays standardized metadata for health records including:
/// - Time/timestamp (for instant records)
/// - Start/end time and duration (for interval records)
/// - Recording method
/// - Optional additional rows for extended metadata
///
/// This widget ensures consistent formatting and spacing across all
/// health record tile types.
@immutable
final class HealthRecordListTileSubtitle extends StatelessWidget {
  /// For instant records with single timestamp.
  const HealthRecordListTileSubtitle.instant({
    required DateTime this.time,
    required this.recordingMethod,
    super.key,
  }) : startTime = null,
       endTime = null,
       additionalRows = null;

  /// For interval records with start/end times.
  const HealthRecordListTileSubtitle.interval({
    required DateTime this.startTime,
    required DateTime this.endTime,
    required this.recordingMethod,
    super.key,
  }) : time = null,
       additionalRows = null;

  /// The timestamp of an instant health record (null for interval records).
  final DateTime? time;

  /// The start time of an interval health record (null for instant records).
  final DateTime? startTime;

  /// The end time of an interval health record (null for instant records).
  final DateTime? endTime;

  /// The recording method used
  /// (e.g., "manual_entry", "automatically_recorded").
  final String recordingMethod;

  /// Optional additional rows to display below the standard metadata.
  ///
  /// Use this for record-specific metadata that doesn't fit the common pattern.
  final List<Widget>? additionalRows;

  /// Formats a duration as a human-readable string (e.g., "2h 30m").
  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) {
      return '$hours${AppTexts.hourShort} $minutes${AppTexts.minuteShort}';
    } else if (hours > 0) {
      return '$hours${AppTexts.hourShort}';
    } else {
      return '$minutes${AppTexts.minuteShort}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        // Display time info based on record type
        if (time != null)
          Text(
            '${AppTexts.time}: ${DateFormatter.formatDateTime(time)}',
          )
        else if (startTime != null && endTime != null) ...[
          Text(
            '${AppTexts.startTime}: '
            '${DateFormatter.formatDateTime(startTime)}',
          ),
          Text(
            '${AppTexts.endTime}: '
            '${DateFormatter.formatDateTime(endTime)}',
          ),
          Text(
            '${AppTexts.duration}: '
            '${_formatDuration(endTime!.difference(startTime!))}',
          ),
        ],
        ...?additionalRows,
      ],
    );
  }
}
