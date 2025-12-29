import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/heart_rate_measurements_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for heart rate series records.
@immutable
final class HeartRateSeriesWriteForm
    extends SeriesHealthRecordWriteForm<HeartRateMeasurement> {
  const HeartRateSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HeartRateSeriesFormState createState() => HeartRateSeriesFormState();
}

/// State for heart rate series form widget.
final class HeartRateSeriesFormState
    extends
        SeriesHealthRecordFormState<
          HeartRateMeasurement,
          HeartRateSeriesWriteForm
        > {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      HeartRateMeasurementsWriteFormFieldGroup(
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
    return HeartRateSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
