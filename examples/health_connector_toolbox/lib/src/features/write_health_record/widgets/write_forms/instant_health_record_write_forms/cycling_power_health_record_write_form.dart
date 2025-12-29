import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for cycling power records.
@immutable
final class CyclingPowerWriteForm extends InstantHealthRecordWriteForm {
  const CyclingPowerWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.cyclingPower);

  @override
  CyclingPowerFormState createState() => CyclingPowerFormState();
}

/// State for cycling power form widget.
final class CyclingPowerFormState
    extends InstantHealthRecordFormState<CyclingPowerWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CyclingPowerRecord(
      time: startDateTime!,
      power: value! as Power,
      metadata: metadata,
    );
  }
}
