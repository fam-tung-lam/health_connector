import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/power_sample_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for power series records.
@immutable
final class PowerSeriesWriteForm
    extends SeriesHealthRecordWriteForm<PowerMeasurement> {
  const PowerSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  PowerSeriesFormState createState() => PowerSeriesFormState();
}

/// State for power series form widget.
final class PowerSeriesFormState
    extends
        SeriesHealthRecordFormState<PowerMeasurement, PowerSeriesWriteForm> {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      PowerSampleWriteFormFieldGroup(
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
    return PowerSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
