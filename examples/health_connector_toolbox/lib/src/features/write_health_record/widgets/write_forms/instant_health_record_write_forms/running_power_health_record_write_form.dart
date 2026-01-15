import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for running power records.
@immutable
final class RunningPowerWriteForm extends InstantHealthRecordWriteForm {
  const RunningPowerWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.runningPower);

  @override
  RunningPowerFormState createState() => RunningPowerFormState();
}

/// State for running power form widget.
final class RunningPowerFormState
    extends InstantHealthRecordFormState<RunningPowerWriteForm> {
  @override
  HealthRecord buildRecord() {
    return RunningPowerRecord(
      time: startDateTime!,
      power: value! as Power,
      metadata: metadata,
    );
  }
}
