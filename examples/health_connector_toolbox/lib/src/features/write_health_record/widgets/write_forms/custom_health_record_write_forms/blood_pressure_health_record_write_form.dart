import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_body_position_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_measurement_location_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
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

  BloodPressureBodyPosition _bodyPosition = BloodPressureBodyPosition.unknown;
  BloodPressureMeasurementLocation _measurementLocation =
      BloodPressureMeasurementLocation.unknown;

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
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<BloodPressureBodyPosition>(
        labelText: 'Body Position',
        values: BloodPressureBodyPosition.values,
        initialValue: _bodyPosition,
        displayNameBuilder: (position) => position.displayName,
        onChanged: (position) {
          if (position != null) {
            setState(() {
              _bodyPosition = position;
            });
          }
        },
      ),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<BloodPressureMeasurementLocation>(
        labelText: 'Measurement Location',
        values: BloodPressureMeasurementLocation.values,
        initialValue: _measurementLocation,
        displayNameBuilder: (location) => location.displayName,
        onChanged: (location) {
          if (location != null) {
            setState(() {
              _measurementLocation = location;
            });
          }
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
      bodyPosition: _bodyPosition,
      measurementLocation: _measurementLocation,
      metadata: metadata,
    );
  }
}
