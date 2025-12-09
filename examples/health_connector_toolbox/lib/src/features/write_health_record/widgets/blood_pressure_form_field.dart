import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart' show Pressure;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A form field widget for entering blood pressure record data.
///
/// Allows entering systolic and diastolic blood pressure values.
@immutable
final class BloodPressureFormField extends StatefulWidget {
  const BloodPressureFormField({
    required this.onChanged,
    super.key,
    this.validator,
  });

  /// Callback when blood pressure data changes.
  ///
  /// Provides both systolic and diastolic pressure values.
  final void Function({
    required Pressure? systolic,
    required Pressure? diastolic,
  })
  onChanged;

  /// Validator for the blood pressure field.
  final String? Function(Pressure? systolic, Pressure? diastolic)? validator;

  @override
  State<BloodPressureFormField> createState() => _BloodPressureFormFieldState();
}

class _BloodPressureFormFieldState extends State<BloodPressureFormField> {
  late final TextEditingController _systolicController;
  late final TextEditingController _diastolicController;
  Pressure? _systolic;
  Pressure? _diastolic;

  @override
  void initState() {
    super.initState();
    _systolicController = TextEditingController();
    _diastolicController = TextEditingController();
    _systolicController.addListener(_notifyChanged);
    _diastolicController.addListener(_notifyChanged);
  }

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    setState(() {
      _systolic = _parsePressure(_systolicController.text);
      _diastolic = _parsePressure(_diastolicController.text);
    });
    widget.onChanged(
      systolic: _systolic,
      diastolic: _diastolic,
    );
  }

  Pressure? _parsePressure(String value) {
    if (value.isEmpty) {
      return null;
    }
    final pressureValue = double.tryParse(value);
    if (pressureValue == null || pressureValue <= 0) {
      return null;
    }
    return Pressure.millimetersOfMercury(pressureValue);
  }

  String? _validateSystolic(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.pleaseEnterSystolicBloodPressure;
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return AppTexts.pleaseEnterValidNumber;
    }
    if (parsed <= 0) {
      return AppTexts.systolicBloodPressureMustBeGreaterThanZero;
    }
    return null;
  }

  String? _validateDiastolic(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.pleaseEnterDiastolicBloodPressure;
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return AppTexts.pleaseEnterValidNumber;
    }
    if (parsed <= 0) {
      return AppTexts.diastolicBloodPressureMustBeGreaterThanZero;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _systolicController,
          decoration: const InputDecoration(
            labelText: AppTexts.systolicBloodPressureValue,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.bloodPressure),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: _validateSystolic,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _diastolicController,
          decoration: const InputDecoration(
            labelText: AppTexts.diastolicBloodPressureValue,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.bloodPressure),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: _validateDiastolic,
        ),
      ],
    );
  }
}
