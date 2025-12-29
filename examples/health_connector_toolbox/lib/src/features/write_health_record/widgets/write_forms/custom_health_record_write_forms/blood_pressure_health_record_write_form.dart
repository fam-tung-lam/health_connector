import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/blood_pressure_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for blood pressure records.
@immutable
final class BloodPressureWriteForm extends BaseHealthRecordWriteForm {
  const BloodPressureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  BloodPressureFormState createState() => BloodPressureFormState();
}

/// State for blood pressure form widget.
final class BloodPressureFormState extends BaseHealthRecordWriteFormState {
  /// Systolic blood pressure value.
  Pressure? systolic;

  /// Diastolic blood pressure value.
  Pressure? diastolic;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      BloodPressureWriteFormField(
        onChanged: ({required systolic, required diastolic}) {
          setState(() {
            this.systolic = systolic;
            this.diastolic = diastolic;
          });
        },
      ),
    ];
  }

  @override
  bool validate() {
    if (!super.validate()) {
      return false;
    }

    return systolic != null && diastolic != null;
  }

  @override
  HealthRecord buildRecord() {
    return BloodPressureRecord(
      time: startDateTime!,
      systolic: systolic!,
      diastolic: diastolic!,
      metadata: metadata,
    );
  }
}
