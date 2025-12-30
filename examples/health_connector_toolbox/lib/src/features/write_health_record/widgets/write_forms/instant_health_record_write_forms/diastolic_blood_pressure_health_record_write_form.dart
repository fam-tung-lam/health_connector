import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_body_position_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_measurement_location_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for diastolic blood pressure records.
final class DiastolicBloodPressureWriteForm
    extends InstantHealthRecordWriteForm {
  const DiastolicBloodPressureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.diastolicBloodPressure);

  @override
  DiastolicBloodPressureFormState createState() =>
      DiastolicBloodPressureFormState();
}

/// State for diastolic blood pressure form widget.
final class DiastolicBloodPressureFormState
    extends InstantHealthRecordFormState<DiastolicBloodPressureWriteForm> {
  BloodPressureBodyPosition _bodyPosition = BloodPressureBodyPosition.unknown;
  BloodPressureMeasurementLocation _measurementLocation =
      BloodPressureMeasurementLocation.unknown;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
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
  HealthRecord buildRecord() {
    // Note: DiastolicBloodPressureRecord does not support bodyPosition and
    // measurementLocation parameters. These fields are for UI consistency
    // with the combined BloodPressureRecord form.
    return DiastolicBloodPressureRecord(
      time: startDateTime!,
      pressure: value! as Pressure,
      metadata: metadata,
    );
  }
}
