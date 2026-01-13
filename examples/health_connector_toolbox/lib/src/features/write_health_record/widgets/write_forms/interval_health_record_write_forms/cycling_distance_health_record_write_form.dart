import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for cycling distance records.
@immutable
final class CyclingDistanceWriteForm extends IntervalHealthRecordWriteForm {
  const CyclingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CyclingDistanceFormState createState() => CyclingDistanceFormState();
}

/// State for cycling distance form widget.
final class CyclingDistanceFormState
    extends IntervalHealthRecordFormState<CyclingDistanceWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.cyclingDistance,
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
    return CyclingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
