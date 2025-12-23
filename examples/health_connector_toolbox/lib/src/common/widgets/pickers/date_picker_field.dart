import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/base_picker_field.dart';

/// A form field widget for selecting a date (without time).
///
/// Displays a read-only text field that opens a date picker when tapped.
/// The selected date is formatted and displayed in the field.
@immutable
final class DatePickerField extends BasePickerField<DateTime> {
  const DatePickerField({
    required super.label,
    required super.onChanged,
    super.key,
    super.initialValue,
    super.validator,
    this.firstDate,
    this.lastDate,
  }) : super(icon: AppIcons.calendarToday);

  /// The earliest date the user can select.
  final DateTime? firstDate;

  /// The latest date the user can select.
  final DateTime? lastDate;

  @override
  String formatValue(DateTime? value) => DateFormatter.formatDate(value);

  @override
  Future<DateTime?> showPicker(
    BuildContext context,
    DateTime? currentValue,
  ) async {
    final now = DateTime.now();
    final initialDate = currentValue ?? now;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (pickedDate == null) {
      return null;
    }

    // Preserve time from current value if it exists, otherwise set to 00:00:00
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      currentValue?.hour ?? 0,
      currentValue?.minute ?? 0,
    );
  }

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState
    extends BasePickerFieldState<DateTime, DatePickerField> {}
