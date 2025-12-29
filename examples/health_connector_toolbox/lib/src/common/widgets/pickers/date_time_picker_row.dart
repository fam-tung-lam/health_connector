import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_picker_field.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/time_picker_field.dart';

/// A reusable widget that displays date and time picker fields in a single row
/// with built-in validation for single date/time selection.
///
/// This widget provides validation to ensure both date and time are selected.
@immutable
final class DateTimePickerRow extends StatelessWidget {
  const DateTimePickerRow({
    required this.startDate,
    required this.startTime,
    required this.onDateChanged,
    required this.onTimeChanged,
    super.key,
    this.dateLabel,
    this.timeLabel,
    this.spacing = 8.0,
    this.validator,
  });

  /// The selected start date (without time).
  final DateTime? startDate;

  /// The selected start time (without date).
  final TimeOfDay? startTime;

  /// Callback when the date is changed.
  final ValueChanged<DateTime> onDateChanged;

  /// Callback when the time is changed.
  final ValueChanged<TimeOfDay> onTimeChanged;

  /// Optional label for the date field. Defaults to [AppTexts.date].
  final String? dateLabel;

  /// Optional label for the time field. Defaults to [AppTexts.time].
  final String? timeLabel;

  /// Spacing between date and time fields. Defaults to 8.0.
  final double spacing;

  /// Optional custom validator. If null, uses the default validation that
  /// requires both date and time to be selected.
  final String? Function()? validator;

  String? _validateDateTime() {
    // Use custom validator if provided
    if (validator != null) {
      return validator!();
    }

    // Default validation
    if (startDate == null) {
      return '${AppTexts.pleaseSelect} ${dateLabel ?? AppTexts.date}';
    }
    if (startTime == null) {
      return '${AppTexts.pleaseSelect} ${timeLabel ?? AppTexts.time}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerField(
            label: dateLabel ?? AppTexts.date,
            initialValue: startDate,
            onChanged: onDateChanged,
            validator: (dateTime) => _validateDateTime(),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: TimePickerField(
            label: timeLabel ?? AppTexts.time,
            initialValue: startTime,
            onChanged: onTimeChanged,
            validator: (timeOfDay) => _validateDateTime(),
          ),
        ),
      ],
    );
  }
}
