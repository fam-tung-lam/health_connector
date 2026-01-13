import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for floors climbed records.
@immutable
final class FloorsClimbedWriteForm extends IntervalHealthRecordWriteForm {
  const FloorsClimbedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  FloorsClimbedFormState createState() => FloorsClimbedFormState();
}

/// State for floors climbed form widget.
final class FloorsClimbedFormState
    extends IntervalHealthRecordFormState<FloorsClimbedWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.floorsClimbed,
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
    return FloorsClimbedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
