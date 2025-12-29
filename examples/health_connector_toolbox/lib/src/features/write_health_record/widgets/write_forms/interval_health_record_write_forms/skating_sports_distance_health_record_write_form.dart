import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for skating sports distance records.
@immutable
final class SkatingSportsDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const SkatingSportsDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SkatingSportsDistanceFormState createState() =>
      SkatingSportsDistanceFormState();
}

/// State for skating sports distance form widget.
final class SkatingSportsDistanceFormState
    extends IntervalHealthRecordFormState<SkatingSportsDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SkatingSportsDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
