import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for wheelchair pushes records.
@immutable
final class WheelchairPushesWriteForm extends IntervalHealthRecordWriteForm {
  const WheelchairPushesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  WheelchairPushesFormState createState() => WheelchairPushesFormState();
}

/// State for wheelchair pushes form widget.
final class WheelchairPushesFormState
    extends IntervalHealthRecordFormState<WheelchairPushesWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.wheelchairPushes,
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
    return WheelchairPushesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
