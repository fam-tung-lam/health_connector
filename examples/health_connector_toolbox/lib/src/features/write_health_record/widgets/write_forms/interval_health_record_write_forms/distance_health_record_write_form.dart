import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for distance records.
@immutable
final class DistanceWriteForm extends IntervalHealthRecordWriteForm {
  const DistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  DistanceFormState createState() => DistanceFormState();
}

/// State for distance form widget.
final class DistanceFormState
    extends IntervalHealthRecordFormState<DistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
