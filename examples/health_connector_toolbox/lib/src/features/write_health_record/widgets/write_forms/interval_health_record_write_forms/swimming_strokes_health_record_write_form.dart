import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for swimming strokes records.
@immutable
final class SwimmingStrokesWriteForm extends IntervalHealthRecordWriteForm {
  const SwimmingStrokesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SwimmingStrokesFormState createState() => SwimmingStrokesFormState();
}

/// State for swimming strokes form widget.
final class SwimmingStrokesFormState
    extends IntervalHealthRecordFormState<SwimmingStrokesWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.swimmingStrokes,
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
    return SwimmingStrokesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
