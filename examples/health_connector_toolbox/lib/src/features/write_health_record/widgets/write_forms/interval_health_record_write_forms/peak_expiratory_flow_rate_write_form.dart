import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for peak expiratory flow rate records.
@immutable
final class PeakExpiratoryFlowRateWriteForm
    extends IntervalHealthRecordWriteForm {
  const PeakExpiratoryFlowRateWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  PeakExpiratoryFlowRateFormState createState() =>
      PeakExpiratoryFlowRateFormState();
}

/// State for peak expiratory flow rate form widget.
final class PeakExpiratoryFlowRateFormState
    extends IntervalHealthRecordFormState<PeakExpiratoryFlowRateWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.peakExpiratoryFlowRate,
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
    return PeakExpiratoryFlowRateRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      volumePerSecond: value! as Volume,
      metadata: metadata,
    );
  }
}
