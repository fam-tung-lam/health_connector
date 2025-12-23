import 'package:flutter/material.dart';

/// A generic dropdown form field for enum values with customizable display
/// names.
///
/// This widget provides a reusable, type-safe dropdown for any enum type,
/// eliminating the need for separate dropdown widgets for each enum.
///
/// Example usage:
/// ```dart
/// EnumDropdownField<MealType>(
///   labelText: 'Meal Type',
///   values: MealType.values,
///   value: selectedMealType,
///   onChanged: (value) => setState(() => selectedMealType = value),
///   displayNameBuilder: (type) => type.displayName,
///   prefixIcon: Icons.fastfood,
/// )
/// ```
@immutable
final class EnumDropdownFormField<T extends Enum> extends StatelessWidget {
  const EnumDropdownFormField({
    required this.labelText,
    required this.values,
    required this.onChanged,
    super.key,
    this.value,
    this.validator,
    this.displayNameBuilder,
    this.prefixIcon,
    this.hint,
    this.enabled = true,
  });

  /// The label text displayed in the input decoration.
  final String labelText;

  /// The list of enum values to display in the dropdown.
  final List<T> values;

  /// The currently selected value.
  final T? value;

  /// Callback when the selected value changes.
  final ValueChanged<T?> onChanged;

  /// Optional validator for form validation.
  final String? Function(T?)? validator;

  /// Optional builder to convert enum values to display strings.
  /// If not provided, uses the enum's `name` property.
  final String Function(T)? displayNameBuilder;

  /// Optional prefix icon for the input decoration.
  final IconData? prefixIcon;

  /// Optional hint text displayed when no value is selected.
  final String? hint;

  /// Whether the dropdown is enabled. Defaults to true.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      hint: hint != null ? Text(hint!) : null,
      items: values.map((enumValue) {
        final displayName =
            displayNameBuilder?.call(enumValue) ?? enumValue.name;
        return DropdownMenuItem<T>(
          value: enumValue,
          child: Text(displayName),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
    );
  }
}
