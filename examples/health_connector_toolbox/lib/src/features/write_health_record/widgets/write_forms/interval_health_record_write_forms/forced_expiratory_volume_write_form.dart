import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for forced expiratory volume records.
@immutable
final class ForcedExpiratoryVolumeWriteForm
    extends IntervalHealthRecordWriteForm {
  const ForcedExpiratoryVolumeWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ForcedExpiratoryVolumeFormState createState() =>
      ForcedExpiratoryVolumeFormState();
}

/// State for forced expiratory volume form widget.
final class ForcedExpiratoryVolumeFormState
    extends IntervalHealthRecordFormState<ForcedExpiratoryVolumeWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.forcedExpiratoryVolume,
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
    return ForcedExpiratoryVolumeRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      volume: value! as Volume,
      metadata: metadata,
    );
  }
}
