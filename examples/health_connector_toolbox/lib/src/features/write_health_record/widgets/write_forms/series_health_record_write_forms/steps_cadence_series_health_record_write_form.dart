import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/steps_cadence_measurements_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for steps cadence series records.
@immutable
final class StepsCadenceSeriesWriteForm
    extends SeriesHealthRecordWriteForm<StepsCadenceSample> {
  const StepsCadenceSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  StepsCadenceSeriesFormState createState() => StepsCadenceSeriesFormState();
}

/// State for steps cadence series form widget.
final class StepsCadenceSeriesFormState
    extends
        SeriesHealthRecordFormState<
          StepsCadenceSample,
          StepsCadenceSeriesWriteForm
        > {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      StepsCadenceMeasurementsWriteFormFieldGroup(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        onChanged: (newSamples) {
          setState(() {
            samples = newSamples ?? [];
          });
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return StepsCadenceSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
