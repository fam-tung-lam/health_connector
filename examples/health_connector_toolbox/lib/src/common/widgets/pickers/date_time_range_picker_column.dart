import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';

/// A reusable widget that displays start and end date/time picker fields
/// in rows with built-in validation for date/time range selection.
///
/// This widget provides validation to ensure:
/// - Both start and end date/time are selected
/// - End date/time is after start date/time
@immutable
final class DateTimeRangePickerColumn extends StatelessWidget {
  const DateTimeRangePickerColumn({
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.onStartDateChanged,
    required this.onStartTimeChanged,
    required this.onEndDateChanged,
    required this.onEndTimeChanged,
    super.key,
    this.startDateLabel,
    this.startTimeLabel,
    this.endDateLabel,
    this.endTimeLabel,
    this.fieldSpacing = 8.0,
    this.rowSpacing = 16.0,
  });

  /// The selected start date (without time).
  final DateTime? startDate;

  /// The selected start time (without date).
  final TimeOfDay? startTime;

  /// The selected end date (without time).
  final DateTime? endDate;

  /// The selected end time (without date).
  final TimeOfDay? endTime;

  /// Callback when the start date is changed.
  final ValueChanged<DateTime> onStartDateChanged;

  /// Callback when the start time is changed.
  final ValueChanged<TimeOfDay> onStartTimeChanged;

  /// Callback when the end date is changed.
  final ValueChanged<DateTime> onEndDateChanged;

  /// Callback when the end time is changed.
  final ValueChanged<TimeOfDay> onEndTimeChanged;

  /// Optional label for the start date field. Defaults to [AppTexts.startDate].
  final String? startDateLabel;

  /// Optional label for the start time field. Defaults to [AppTexts.startTime].
  final String? startTimeLabel;

  /// Optional label for the end date field. Defaults to [AppTexts.endDate].
  final String? endDateLabel;

  /// Optional label for the end time field. Defaults to [AppTexts.endTime].
  final String? endTimeLabel;

  /// Spacing between date and time fields within a row. Defaults to 8.0.
  final double fieldSpacing;

  /// Spacing between the start and end rows. Defaults to 16.0.
  final double rowSpacing;

  /// Computes the combined start date and time as a DateTime object.
  DateTime? get _startDateTime => DateFormatter.combine(startDate, startTime);

  /// Computes the combined end date and time as a DateTime object.
  DateTime? get _endDateTime => DateFormatter.combine(endDate, endTime);

  String? _validateStartDateTime() {
    if (startDate == null) {
      return '${AppTexts.pleaseSelect} ${startDateLabel ?? AppTexts.startDate}';
    }
    if (startTime == null) {
      return '${AppTexts.pleaseSelect} ${startTimeLabel ?? AppTexts.startTime}';
    }
    if (endDate == null || endTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }
    final start = _startDateTime;
    final end = _endDateTime;
    if (start != null &&
        end != null &&
        (end.isBefore(start) || end.isAtSameMomentAs(start))) {
      return AppTexts.endTimeMustBeAfterStartTime;
    }
    return null;
  }

  String? _validateEndDateTime() {
    if (endDate == null) {
      return '${AppTexts.pleaseSelect} ${endDateLabel ?? AppTexts.endDate}';
    }
    if (endTime == null) {
      return '${AppTexts.pleaseSelect} ${endTimeLabel ?? AppTexts.endTime}';
    }
    if (startDate == null || startTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }
    final start = _startDateTime;
    final end = _endDateTime;
    if (start != null &&
        end != null &&
        (end.isBefore(start) || end.isAtSameMomentAs(start))) {
      return AppTexts.endTimeMustBeAfterStartTime;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Start Date and Time row
        DateTimePickerRow(
          startDate: startDate,
          startTime: startTime,
          onDateChanged: onStartDateChanged,
          onTimeChanged: onStartTimeChanged,
          dateLabel: startDateLabel ?? AppTexts.startDate,
          timeLabel: startTimeLabel ?? AppTexts.startTime,
          spacing: fieldSpacing,
          validator: _validateStartDateTime,
        ),
        SizedBox(height: rowSpacing),
        // End Date and Time row
        DateTimePickerRow(
          startDate: endDate,
          startTime: endTime,
          onDateChanged: onEndDateChanged,
          onTimeChanged: onEndTimeChanged,
          dateLabel: endDateLabel ?? AppTexts.endDate,
          timeLabel: endTimeLabel ?? AppTexts.endTime,
          spacing: fieldSpacing,
          validator: _validateEndDateTime,
        ),
      ],
    );
  }
}
