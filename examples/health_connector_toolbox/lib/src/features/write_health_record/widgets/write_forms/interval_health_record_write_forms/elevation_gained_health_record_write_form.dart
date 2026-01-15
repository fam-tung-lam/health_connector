import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for elevation gained records.
@immutable
final class ElevationGainedWriteForm extends IntervalHealthRecordWriteForm {
  const ElevationGainedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ElevationGainedFormState createState() => ElevationGainedFormState();
}

/// State for elevation gained form widget.
final class ElevationGainedFormState
    extends IntervalHealthRecordFormState<ElevationGainedWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.elevationGained,
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
    return ElevationGainedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      elevation: value! as Length,
      metadata: metadata,
    );
  }
}
