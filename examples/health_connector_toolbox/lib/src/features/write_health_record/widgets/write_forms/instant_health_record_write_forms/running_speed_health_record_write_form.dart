import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for running speed records.
@immutable
final class RunningSpeedWriteForm extends InstantHealthRecordWriteForm {
  const RunningSpeedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.runningSpeed);

  @override
  RunningSpeedFormState createState() => RunningSpeedFormState();
}

/// State for running speed form widget.
final class RunningSpeedFormState
    extends InstantHealthRecordFormState<RunningSpeedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return RunningSpeedRecord(
      time: startDateTime!,
      speed: value! as Velocity,
      metadata: metadata,
    );
  }
}
