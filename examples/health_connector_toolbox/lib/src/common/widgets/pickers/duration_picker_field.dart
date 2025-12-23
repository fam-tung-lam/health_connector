import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/base_picker_field.dart';

/// A form field widget for selecting a duration using a time picker.
///
/// Uses TimeOfDay to represent duration in hours and minutes (HH:MM format).
/// Displays a read-only text field that opens a time picker when tapped.
@immutable
final class DurationPickerField extends BasePickerField<TimeOfDay> {
  const DurationPickerField({
    required super.onChanged,
    super.key,
    super.initialValue,
    super.validator,
    super.onTap,
    super.label = AppTexts.durationHHMM,
  }) : super(icon: AppIcons.accessTime);

  @override
  String formatValue(TimeOfDay? value) => DateFormatter.formatTime(value);

  @override
  Future<TimeOfDay?> showPicker(
    BuildContext context,
    TimeOfDay? currentValue,
  ) {
    return showTimePicker(
      context: context,
      initialTime: currentValue ?? TimeOfDay.now(),
    );
  }

  @override
  State<DurationPickerField> createState() => _DurationPickerFieldState();
}

class _DurationPickerFieldState
    extends BasePickerFieldState<TimeOfDay, DurationPickerField> {}
