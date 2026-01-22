import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for running ground contact time records.
@immutable
final class RunningGroundContactTimeWriteForm
    extends IntervalHealthRecordWriteForm {
  const RunningGroundContactTimeWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  RunningGroundContactTimeFormState createState() =>
      RunningGroundContactTimeFormState();
}

/// State for running ground contact time form widget.
final class RunningGroundContactTimeFormState
    extends IntervalHealthRecordFormState<RunningGroundContactTimeWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.runningGroundContactTime,
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
    return RunningGroundContactTimeRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      groundContactTime: value! as TimeDuration,
      metadata: metadata,
    );
  }
}
