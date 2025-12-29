import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Base widget for instant health record forms.
@immutable
abstract class InstantHealthRecordWriteForm extends BaseHealthRecordWriteForm {
  const InstantHealthRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    required this.dataType,
    super.key,
  });

  /// The health data type for this instant record.
  final HealthDataType dataType;

  @override
  InstantHealthRecordFormState createState();
}

/// Base state for instant health record forms.
abstract class InstantHealthRecordFormState<
  T extends InstantHealthRecordWriteForm
>
    extends BaseHealthRecordWriteFormState<T> {
  /// The main value for this instant record (e.g., weight, heart rate).
  MeasurementUnit? value;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      HealthRecordValueWriteFormField(
        dataType: widget.dataType,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    ];
  }
}
