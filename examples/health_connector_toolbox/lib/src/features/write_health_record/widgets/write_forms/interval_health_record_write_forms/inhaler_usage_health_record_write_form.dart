import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for inhaler usage records.
@immutable
final class InhalerUsageWriteForm extends IntervalHealthRecordWriteForm {
  const InhalerUsageWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  InhalerUsageFormState createState() => InhalerUsageFormState();
}

/// State for inhaler usage form widget.
final class InhalerUsageFormState
    extends IntervalHealthRecordFormState<InhalerUsageWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.inhalerUsage,
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
    return InhalerUsageRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      puffs: value! as Number,
      metadata: metadata,
    );
  }
}
