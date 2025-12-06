import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart' show MealType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A dropdown widget for selecting a meal type.
///
/// Displays all available meal types with their display names.
@immutable
final class MealTypeDropdownField extends StatelessWidget {
  const MealTypeDropdownField({
    required this.value,
    required this.onChanged,
    super.key,
    this.validator,
  });

  /// The currently selected meal type.
  final MealType? value;

  /// Callback when the selected value changes.
  final ValueChanged<MealType?> onChanged;

  /// Validator for the dropdown field.
  final String? Function(MealType?)? validator;

  /// Maps a [MealType] to its display string.
  static String _getDisplayName(MealType type) {
    return switch (type) {
      MealType.unknown => AppTexts.mealTypeUnknown,
      MealType.breakfast => AppTexts.mealTypeBreakfast,
      MealType.lunch => AppTexts.mealTypeLunch,
      MealType.dinner => AppTexts.mealTypeDinner,
      MealType.snack => AppTexts.mealTypeSnack,
    };
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MealType>(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: AppTexts.mealType,
        border: OutlineInputBorder(),
        prefixIcon: Icon(AppIcons.fastfood),
      ),
      hint: const Text(AppTexts.pleaseSelect),
      items: MealType.values.map((type) {
        return DropdownMenuItem<MealType>(
          value: type,
          child: Text(_getDisplayName(type)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
