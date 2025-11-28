import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A dropdown widget for selecting a sleep stage type.
///
/// Displays all available sleep stage types with their display names.
@immutable
final class SleepStageTypeDropdownField extends StatelessWidget {
  const SleepStageTypeDropdownField({
    required this.value,
    required this.onChanged,
    super.key,
    this.validator,
  });

  /// The currently selected sleep stage type.
  final SleepStageType? value;

  /// Callback when the selected value changes.
  final ValueChanged<SleepStageType?> onChanged;

  /// Validator for the dropdown field.
  final String? Function(SleepStageType?)? validator;

  /// Maps a [SleepStageType] to its display string.
  static String _getDisplayName(SleepStageType type) {
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

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SleepStageType>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: AppTexts.sleepStageType,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(AppIcons.bedtime),
        errorText: validator?.call(value),
      ),
      hint: const Text(AppTexts.pleaseSelect),
      items: SleepStageType.values.map((type) {
        return DropdownMenuItem<SleepStageType>(
          value: type,
          child: Text(_getDisplayName(type)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
