import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for swimming distance records.
@immutable
final class SwimmingDistanceWriteForm extends IntervalHealthRecordWriteForm {
  const SwimmingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SwimmingDistanceFormState createState() => SwimmingDistanceFormState();
}

/// State for swimming distance form widget.
final class SwimmingDistanceFormState
    extends IntervalHealthRecordFormState<SwimmingDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SwimmingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
