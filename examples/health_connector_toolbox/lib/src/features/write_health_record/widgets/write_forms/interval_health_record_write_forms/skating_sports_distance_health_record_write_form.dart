import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for skating sports distance records.
@immutable
final class SkatingSportsDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const SkatingSportsDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SkatingSportsDistanceFormState createState() =>
      SkatingSportsDistanceFormState();
}

/// State for skating sports distance form widget.
final class SkatingSportsDistanceFormState
    extends IntervalHealthRecordFormState<SkatingSportsDistanceWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.skatingSportsDistance,
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
    return SkatingSportsDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
