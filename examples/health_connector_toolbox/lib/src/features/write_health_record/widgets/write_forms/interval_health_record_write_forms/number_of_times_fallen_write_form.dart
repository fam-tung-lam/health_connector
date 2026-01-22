import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for number of times fallen records.
@immutable
final class NumberOfTimesFallenWriteForm extends IntervalHealthRecordWriteForm {
  const NumberOfTimesFallenWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  NumberOfTimesFallenFormState createState() => NumberOfTimesFallenFormState();
}

/// State for number of times fallen form widget.
final class NumberOfTimesFallenFormState
    extends IntervalHealthRecordFormState<NumberOfTimesFallenWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.numberOfTimesFallen,
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
    return NumberOfTimesFallenRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
