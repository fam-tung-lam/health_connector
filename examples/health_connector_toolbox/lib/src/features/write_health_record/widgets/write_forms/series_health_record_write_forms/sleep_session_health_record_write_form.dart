import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/sleep_session_record_sleep_stages_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for sleep session records (Android).
@immutable
final class SleepSessionWriteForm
    extends SeriesHealthRecordWriteForm<SleepStageSample> {
  const SleepSessionWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SleepSessionFormState createState() => SleepSessionFormState();
}

/// State for sleep session form widget.
final class SleepSessionFormState
    extends
        SeriesHealthRecordFormState<SleepStageSample, SleepSessionWriteForm> {
  String? title;
  String? notes;

  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.titleOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.optionalTitleSleepRecord,
        ),
        onChanged: (value) => setState(() {
          title = value.isEmpty ? null : value;
        }),
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.notesOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.optionalNotesSleepRecord,
        ),
        maxLines: 3,
        onChanged: (value) => setState(() {
          notes = value.isEmpty ? null : value;
        }),
      ),
      SleepSessionRecordSleepStagesFormField(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        onChanged: (stages) {
          setState(() {
            samples = stages ?? [];
          });
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return SleepSessionRecord(
      id: HealthRecordId.none,
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }
}
