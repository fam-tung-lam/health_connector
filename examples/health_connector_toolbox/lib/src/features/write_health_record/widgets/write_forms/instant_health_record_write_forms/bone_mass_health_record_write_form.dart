import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for bone mass records.
@immutable
final class BoneMassWriteForm extends InstantHealthRecordWriteForm {
  const BoneMassWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.boneMass);

  @override
  BoneMassFormState createState() => BoneMassFormState();
}

/// State for bone mass form widget.
final class BoneMassFormState
    extends InstantHealthRecordFormState<BoneMassWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BoneMassRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}
