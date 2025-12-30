import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/basal_body_temperature_measurement_location_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for basal body temperature records.
final class BasalBodyTemperatureWriteForm extends InstantHealthRecordWriteForm {
  const BasalBodyTemperatureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.basalBodyTemperature);

  @override
  BasalBodyTemperatureFormState createState() =>
      BasalBodyTemperatureFormState();
}

/// State for basal body temperature form widget.
final class BasalBodyTemperatureFormState
    extends InstantHealthRecordFormState<BasalBodyTemperatureWriteForm> {
  BasalBodyTemperatureMeasurementLocation _measurementLocation =
      BasalBodyTemperatureMeasurementLocation.unknown;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<BasalBodyTemperatureMeasurementLocation>(
        labelText: 'Measurement Location',
        values: BasalBodyTemperatureMeasurementLocation.values,
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
    return BasalBodyTemperatureRecord(
      time: startDateTime!,
      temperature: value! as Temperature,
      measurementLocation: _measurementLocation,
      metadata: metadata,
    );
  }
}
