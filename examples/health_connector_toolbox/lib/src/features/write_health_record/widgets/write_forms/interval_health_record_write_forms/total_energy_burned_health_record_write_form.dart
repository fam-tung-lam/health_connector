import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for total energy burned records.
@immutable
final class TotalEnergyBurnedWriteForm extends IntervalHealthRecordWriteForm {
  const TotalEnergyBurnedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  TotalEnergyBurnedFormState createState() => TotalEnergyBurnedFormState();
}

/// State for total energy burned form widget.
final class TotalEnergyBurnedFormState
    extends IntervalHealthRecordFormState<TotalEnergyBurnedWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.totalEnergyBurned,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return TotalEnergyBurnedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      energy: value! as Energy,
      metadata: metadata,
    );
  }
}
