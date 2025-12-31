import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for body water mass records.
@immutable
final class BodyWaterMassWriteForm extends InstantHealthRecordWriteForm {
  const BodyWaterMassWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bodyWaterMass);

  @override
  BodyWaterMassFormState createState() => BodyWaterMassFormState();
}

/// State for body water mass form widget.
final class BodyWaterMassFormState
    extends InstantHealthRecordFormState<BodyWaterMassWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BodyWaterMassRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}
