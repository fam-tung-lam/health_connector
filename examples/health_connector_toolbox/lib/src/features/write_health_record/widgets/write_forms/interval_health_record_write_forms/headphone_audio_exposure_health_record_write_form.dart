import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for headphone audio exposure records.
@immutable
final class HeadphoneAudioExposureWriteForm
    extends IntervalHealthRecordWriteForm {
  const HeadphoneAudioExposureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HeadphoneAudioExposureFormState createState() =>
      HeadphoneAudioExposureFormState();
}

/// State for headphone audio exposure form widget.
final class HeadphoneAudioExposureFormState
    extends IntervalHealthRecordFormState<HeadphoneAudioExposureWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.headphoneAudioExposure,
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
    return HeadphoneAudioExposureRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      aWeightedDecibel: value! as Number,
      metadata: metadata,
    );
  }
}
