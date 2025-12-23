import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HealthDataType, MeasurementUnit;
import 'package:health_connector_toolbox/src/common/utils/extensions/health_data_type_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_parser.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_validator.dart';

/// A widget that renders the appropriate value input field based on
/// the health data type.
///
/// This widget uses extension methods on [HealthDataType] to determine the
/// appropriate input field configuration, parsing logic, and validation rules
/// for each health data type. This eliminates the need for massive switch
/// statements and centralizes all configuration in one place.
///
/// Example:
/// ```dart
/// HealthRecordValueField(
///   dataType: StepsHealthDataType(),
///   onChanged: (value) {
///     if (value != null) {
///       print('Steps: ${(value as Number).value}');
///     }
///   },
/// )
/// ```
@immutable
final class HealthRecordValueFormField extends StatefulWidget {
  const HealthRecordValueFormField({
    required this.dataType,
    required this.onChanged,
    super.key,
    this.validator,
  });

  /// The health data type that determines which input field to render.
  final HealthDataType dataType;

  /// Callback when the value changes.
  ///
  /// Provides a [MeasurementUnit] object (e.g., `Number`, `Mass`) or null
  /// if the input is invalid or empty.
  final ValueChanged<MeasurementUnit?> onChanged;

  /// Optional custom validator for the value field.
  ///
  /// If not provided, uses the default validation from the UI config.
  final String? Function(MeasurementUnit?)? validator;

  @override
  State<HealthRecordValueFormField> createState() =>
      _HealthRecordValueFormFieldState();
}

class _HealthRecordValueFormFieldState
    extends State<HealthRecordValueFormField> {
  late final TextEditingController controller;

  MeasurementUnit? _value;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Handles text input changes and parses the value.
  void _onChanged(String value) {
    setState(() {
      try {
        _value = MeasurementUnitValueParser.parseValue(
          forDataType: widget.dataType,
          value: value,
        );
      } on FormatException catch (_) {
        // Invalid input - set to null
        _value = null;
      } on ArgumentError catch (_) {
        // Empty input - set to null
        _value = null;
      }
    });
    widget.onChanged(_value);
  }

  /// Validates the input.
  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return widget.dataType.emptyInputError;
    }

    try {
      final parsedValue = MeasurementUnitValueParser.parseValue(
        forDataType: widget.dataType,
        value: value,
      );

      MeasurementUnitValueValidator.validate(
        forDataType: widget.dataType,
        value: parsedValue,
      );

      // Validation successful
      return null;
    } on FormatException catch (e) {
      return e.message;
    } on ArgumentError catch (e) {
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: widget.dataType.fieldLabel,
        suffixText: widget.dataType.fieldSuffix,
        prefixIcon: Icon(widget.dataType.icon),
      ),
      keyboardType: widget.dataType.keyboardType,
      onChanged: _onChanged,
      validator: _validate,
    );
  }
}
