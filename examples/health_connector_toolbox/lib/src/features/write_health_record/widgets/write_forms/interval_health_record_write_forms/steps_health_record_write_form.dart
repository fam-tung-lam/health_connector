import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for steps records.
@immutable
final class StepsWriteForm extends IntervalHealthRecordWriteForm {
  const StepsWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  StepsFormState createState() => StepsFormState();
}

/// State for steps form widget.
final class StepsFormState
    extends IntervalHealthRecordFormState<StepsWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.steps,
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
    return StepsRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
