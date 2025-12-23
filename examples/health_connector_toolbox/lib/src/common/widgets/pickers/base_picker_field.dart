import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Base class for read-only text fields that open platform pickers.
///
/// This abstraction provides common functionality for all picker-based form
/// fields, including:
/// - Text controller and state management
/// - Lifecycle methods (initState, didUpdateWidget, dispose)
/// - Validation logic
/// - Common UI structure
///
/// Concrete implementations must provide:
/// - [formatValue]: How to format the value for display
/// - [showPicker]: How to display the picker dialog
abstract class BasePickerField<T> extends StatefulWidget {
  const BasePickerField({
    required this.label,
    required this.onChanged,
    required this.icon,
    super.key,
    this.initialValue,
    this.validator,
    this.onTap,
  });

  /// Label text for the form field.
  final String label;

  /// Initial value to display in the picker.
  final T? initialValue;

  /// Callback when the user selects a value.
  final ValueChanged<T> onChanged;

  /// Optional validator for the selected value.
  final String? Function(T?)? validator;

  /// Optional callback invoked when the field is tapped, before showing the
  /// picker. Useful for analytics or pre-selection logic.
  final VoidCallback? onTap;

  /// Icon to display in the suffix of the text field.
  final IconData icon;

  /// Formats the value for display in the text field.
  ///
  /// Returns empty string if value is null.
  String formatValue(T? value);

  /// Shows the picker dialog and returns the selected value.
  ///
  /// Returns null if the user cancels the picker.
  Future<T?> showPicker(BuildContext context, T? currentValue);
}

/// Base state class for picker fields.
///
/// Manages the text controller, selected value, and picker interaction logic.
abstract class BasePickerFieldState<T, W extends BasePickerField<T>>
    extends State<W> {
  late final TextEditingController _controller;
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _controller = TextEditingController(
      text: widget.formatValue(_selectedValue),
    );
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedValue = widget.initialValue;
      _controller.text = widget.formatValue(_selectedValue);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectValue(BuildContext context) async {
    widget.onTap?.call();
    final picked = await widget.showPicker(context, _selectedValue);
    if (picked == null) {
      return;
    }

    setState(() {
      _selectedValue = picked;
      _controller.text = widget.formatValue(picked);
    });

    widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: Icon(widget.icon),
        border: const OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () => _selectValue(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${AppTexts.pleaseSelect} ${widget.label}';
        }
        return widget.validator?.call(_selectedValue);
      },
    );
  }
}
