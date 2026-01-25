import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for menstruation period records.
@immutable
final class MenstruationPeriodRecordWriteForm
    extends IntervalHealthRecordWriteForm {
  const MenstruationPeriodRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  MenstruationPeriodRecordWriteFormState createState() =>
      MenstruationPeriodRecordWriteFormState();
}

/// State for menstruation period form widget.
final class MenstruationPeriodRecordWriteFormState
    extends IntervalHealthRecordFormState<MenstruationPeriodRecordWriteForm> {
  @override
  HealthRecord buildRecord() {
    return MenstruationPeriodRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      metadata: metadata,
    );
  }
}
