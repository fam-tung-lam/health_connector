import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for heart rate recovery one minute records.
@immutable
final class HeartRateRecoveryOneMinuteWriteForm
    extends IntervalHealthRecordWriteForm {
  const HeartRateRecoveryOneMinuteWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HeartRateRecoveryOneMinuteFormState createState() =>
      HeartRateRecoveryOneMinuteFormState();
}

/// State for heart rate recovery one minute form widget.
final class HeartRateRecoveryOneMinuteFormState
    extends IntervalHealthRecordFormState<HeartRateRecoveryOneMinuteWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.heartRateRecoveryOneMinute,
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
    return HeartRateRecoveryOneMinuteRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      rate: value! as Frequency,
      metadata: metadata,
    );
  }
}
