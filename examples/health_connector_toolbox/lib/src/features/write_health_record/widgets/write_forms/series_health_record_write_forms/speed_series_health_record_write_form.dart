import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/speed_sample_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for speed series records.
@immutable
final class SpeedSeriesWriteForm
    extends SeriesHealthRecordWriteForm<SpeedMeasurement> {
  const SpeedSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SpeedSeriesFormState createState() => SpeedSeriesFormState();
}

/// State for speed series form widget.
final class SpeedSeriesFormState
    extends
        SeriesHealthRecordFormState<SpeedMeasurement, SpeedSeriesWriteForm> {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      SpeedSampleWriteFormFieldGroup(
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
    return SpeedSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
