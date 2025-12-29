import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for lean body mass records.
@immutable
final class LeanBodyMassWriteForm extends InstantHealthRecordWriteForm {
  const LeanBodyMassWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.leanBodyMass);

  @override
  LeanBodyMassFormState createState() => LeanBodyMassFormState();
}

/// State for lean body mass form widget.
final class LeanBodyMassFormState
    extends InstantHealthRecordFormState<LeanBodyMassWriteForm> {
  @override
  HealthRecord buildRecord() {
    return LeanBodyMassRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}
