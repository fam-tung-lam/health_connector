import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for cross country skiing distance records.
@immutable
final class CrossCountrySkiingDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const CrossCountrySkiingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CrossCountrySkiingDistanceFormState createState() =>
      CrossCountrySkiingDistanceFormState();
}

/// State for cross country skiing distance form widget.
final class CrossCountrySkiingDistanceFormState
    extends IntervalHealthRecordFormState<CrossCountrySkiingDistanceWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.crossCountrySkiingDistance,
        onChanged: (MeasurementUnit? newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return CrossCountrySkiingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
