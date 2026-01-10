import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for floors climbed records.
@immutable
final class FloorsClimbedWriteForm extends IntervalHealthRecordWriteForm {
  const FloorsClimbedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  FloorsClimbedFormState createState() => FloorsClimbedFormState();
}

/// State for floors climbed form widget.
final class FloorsClimbedFormState
    extends IntervalHealthRecordFormState<FloorsClimbedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return FloorsClimbedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
