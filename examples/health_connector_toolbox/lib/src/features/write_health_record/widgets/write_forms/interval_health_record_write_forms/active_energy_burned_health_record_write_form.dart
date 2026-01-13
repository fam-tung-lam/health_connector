import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for active energy burned records.
@immutable
final class ActiveEnergyBurnedWriteForm extends IntervalHealthRecordWriteForm {
  const ActiveEnergyBurnedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ActiveEnergyBurnedFormState createState() => ActiveEnergyBurnedFormState();
}

/// State for active energy burned form widget.
final class ActiveEnergyBurnedFormState
    extends IntervalHealthRecordFormState<ActiveEnergyBurnedWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.activeEnergyBurned,
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
    return ActiveEnergyBurnedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      energy: value! as Energy,
      metadata: metadata,
    );
  }
}
