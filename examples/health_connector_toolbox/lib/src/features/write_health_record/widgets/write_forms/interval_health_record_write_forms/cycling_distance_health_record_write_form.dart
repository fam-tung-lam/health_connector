import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for cycling distance records.
@immutable
final class CyclingDistanceWriteForm extends IntervalHealthRecordWriteForm {
  const CyclingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CyclingDistanceFormState createState() => CyclingDistanceFormState();
}

/// State for cycling distance form widget.
final class CyclingDistanceFormState
    extends IntervalHealthRecordFormState<CyclingDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CyclingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
