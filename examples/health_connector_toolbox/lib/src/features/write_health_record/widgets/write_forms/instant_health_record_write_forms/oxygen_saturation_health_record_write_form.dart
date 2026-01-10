import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for oxygen saturation records.
@immutable
final class OxygenSaturationWriteForm extends InstantHealthRecordWriteForm {
  const OxygenSaturationWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.oxygenSaturation);

  @override
  OxygenSaturationFormState createState() => OxygenSaturationFormState();
}

/// State for oxygen saturation form widget.
final class OxygenSaturationFormState
    extends InstantHealthRecordFormState<OxygenSaturationWriteForm> {
  @override
  HealthRecord buildRecord() {
    return OxygenSaturationRecord(
      time: startDateTime!,
      saturation: value! as Percentage,
      metadata: metadata,
    );
  }
}
