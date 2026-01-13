import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for active energy burned records.
@immutable
final class ActiveEnergyBurnedWriteForm extends IntervalHealthRecordWriteForm {
  const ActiveEnergyBurnedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ActiveEnergyBurnedFormState createState() => ActiveEnergyBurnedFormState();
}

/// State for active energy burned form widget.
final class ActiveEnergyBurnedFormState
    extends IntervalHealthRecordFormState<ActiveEnergyBurnedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ActiveEnergyBurnedRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      energy: value! as Energy,
      metadata: metadata,
    );
  }
}
