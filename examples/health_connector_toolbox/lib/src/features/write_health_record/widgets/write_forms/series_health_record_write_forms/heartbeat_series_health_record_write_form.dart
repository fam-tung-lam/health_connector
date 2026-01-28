import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/heartbeat_sample_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for heartbeat series records.
@immutable
final class HeartbeatSeriesWriteForm
    extends SeriesHealthRecordWriteForm<HeartbeatSample> {
  const HeartbeatSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HeartbeatSeriesFormState createState() => HeartbeatSeriesFormState();
}

/// State for heartbeat series form widget.
final class HeartbeatSeriesFormState
    extends
        SeriesHealthRecordFormState<HeartbeatSample, HeartbeatSeriesWriteForm> {
  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      HeartbeatSampleWriteFormFieldGroup(
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
    return HeartbeatSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
    );
  }
}
