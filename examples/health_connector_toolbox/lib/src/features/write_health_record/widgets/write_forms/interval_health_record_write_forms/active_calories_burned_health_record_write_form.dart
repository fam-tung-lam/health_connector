import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for active calories burned records.
@immutable
final class ActiveCaloriesBurnedWriteForm
    extends IntervalHealthRecordWriteForm {
  const ActiveCaloriesBurnedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ActiveCaloriesBurnedFormState createState() =>
      ActiveCaloriesBurnedFormState();
}

/// State for active calories burned form widget.
final class ActiveCaloriesBurnedFormState
    extends IntervalHealthRecordFormState<ActiveCaloriesBurnedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ActiveCaloriesBurnedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      energy: value! as Energy,
      metadata: metadata,
    );
  }
}
