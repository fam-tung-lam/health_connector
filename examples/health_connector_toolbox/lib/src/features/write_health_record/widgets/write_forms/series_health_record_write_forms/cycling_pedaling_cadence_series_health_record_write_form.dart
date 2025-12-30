import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/cycling_pedaling_cadence_measurements_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for cycling pedaling cadence series records.
@immutable
final class CyclingPedalingCadenceSeriesWriteForm
    extends SeriesHealthRecordWriteForm<CyclingPedalingCadenceMeasurement> {
  const CyclingPedalingCadenceSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CyclingPedalingCadenceSeriesFormState createState() =>
      CyclingPedalingCadenceSeriesFormState();
}

/// State for cycling pedaling cadence series form widget.
final class CyclingPedalingCadenceSeriesFormState
    extends
        SeriesHealthRecordFormState<
          CyclingPedalingCadenceMeasurement,
          CyclingPedalingCadenceSeriesWriteForm
        > {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      CyclingPedalingCadenceMeasurementsWriteFormFieldGroup(
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
    return CyclingPedalingCadenceSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
