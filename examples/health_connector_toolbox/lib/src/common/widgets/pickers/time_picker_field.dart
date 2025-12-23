import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/base_picker_field.dart';

/// A form field widget for selecting a time (without date).
///
/// Displays a read-only text field that opens a time picker when tapped.
/// The selected time is formatted and displayed in the field.
@immutable
final class TimePickerField extends BasePickerField<TimeOfDay> {
  const TimePickerField({
    required super.label,
    required super.onChanged,
    super.key,
    super.initialValue,
    super.validator,
  }) : super(icon: AppIcons.accessTime);

  @override
  String formatValue(TimeOfDay? value) => DateFormatter.formatTime(value);

  @override
  Future<TimeOfDay?> showPicker(
    BuildContext context,
    TimeOfDay? currentValue,
  ) async {
    final now = TimeOfDay.now();
    return showTimePicker(
      context: context,
      initialTime: currentValue ?? now,
    );
  }

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState
    extends BasePickerFieldState<TimeOfDay, TimePickerField> {}
