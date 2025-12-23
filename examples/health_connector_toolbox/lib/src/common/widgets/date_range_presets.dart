import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Preset date range options for quick selection.
enum DateRangePreset {
  lastHour,
  today,
  last7Days,
  last30Days;

  String get displayName {
    return switch (this) {
      DateRangePreset.lastHour => AppTexts.lastHour,
      DateRangePreset.today => AppTexts.today,
      DateRangePreset.last7Days => AppTexts.last7Days,
      DateRangePreset.last30Days => AppTexts.last30Days,
    };
  }

  /// Returns the start and end DateTime for this preset.
  ({DateTime start, DateTime end}) getDateRange() {
    final now = DateTime.now();

    return switch (this) {
      DateRangePreset.lastHour => (
        start: now.subtract(const Duration(hours: 1)),
        end: now,
      ),
      DateRangePreset.today => (
        start: DateTime(now.year, now.month, now.day),
        end: now,
      ),
      DateRangePreset.last7Days => (
        start: now.subtract(const Duration(days: 7)),
        end: now,
      ),
      DateRangePreset.last30Days => (
        start: now.subtract(const Duration(days: 30)),
        end: now,
      ),
    };
  }
}

/// A widget that displays quick preset chips for common date ranges.
///
/// When a chip is tapped, it calls the [onPresetSelected] callback with
/// the start and end DateTime values for that preset.
@immutable
final class DateRangePresets extends StatelessWidget {
  const DateRangePresets({
    required this.onPresetSelected,
    super.key,
  });

  /// Callback when a preset is selected.
  /// Parameters are (startDate, startTime, endDate, endTime).
  final void Function(
    DateTime startDate,
    TimeOfDay startTime,
    DateTime endDate,
    TimeOfDay endTime,
  )
  onPresetSelected;

  void _handlePresetTap(DateRangePreset preset) {
    final range = preset.getDateRange();

    // Extract date and time components
    final startDate = DateTime(
      range.start.year,
      range.start.month,
      range.start.day,
    );
    final startTime = TimeOfDay.fromDateTime(range.start);

    final endDate = DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
    );
    final endTime = TimeOfDay.fromDateTime(range.end);

    onPresetSelected(startDate, startTime, endDate, endTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: DateRangePreset.values.map((preset) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(preset.displayName),
              onPressed: () => _handlePresetTap(preset),
            ),
          );
        }).toList(),
      ),
    );
  }
}
