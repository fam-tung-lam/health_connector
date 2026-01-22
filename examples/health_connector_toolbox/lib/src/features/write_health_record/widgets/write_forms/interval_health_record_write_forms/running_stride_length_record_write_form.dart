import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for running stride length records.
@immutable
final class RunningStrideLengthWriteForm extends IntervalHealthRecordWriteForm {
  const RunningStrideLengthWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  RunningStrideLengthFormState createState() => RunningStrideLengthFormState();
}

/// State for running stride length form widget.
final class RunningStrideLengthFormState
    extends IntervalHealthRecordFormState<RunningStrideLengthWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.runningStrideLength,
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
    return RunningStrideLengthRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      strideLength: value! as Length,
      metadata: metadata,
    );
  }
}
