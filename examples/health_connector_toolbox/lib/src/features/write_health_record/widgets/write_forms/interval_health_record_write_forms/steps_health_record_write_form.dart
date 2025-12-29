import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for steps records.
@immutable
final class StepsWriteForm extends IntervalHealthRecordWriteForm {
  const StepsWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  StepsFormState createState() => StepsFormState();
}

/// State for steps form widget.
final class StepsFormState
    extends IntervalHealthRecordFormState<StepsWriteForm> {
  @override
  HealthRecord buildRecord() {
    return StepsRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      count: value! as Number,
      metadata: metadata,
    );
  }
}
