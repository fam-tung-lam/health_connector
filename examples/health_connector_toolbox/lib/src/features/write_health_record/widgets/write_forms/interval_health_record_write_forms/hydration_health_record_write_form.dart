import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for hydration records.
@immutable
final class HydrationWriteForm extends IntervalHealthRecordWriteForm {
  const HydrationWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HydrationFormState createState() => HydrationFormState();
}

/// State for hydration form widget.
final class HydrationFormState
    extends IntervalHealthRecordFormState<HydrationWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.hydration,
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
    return HydrationRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      volume: value! as Volume,
      metadata: metadata,
    );
  }
}
