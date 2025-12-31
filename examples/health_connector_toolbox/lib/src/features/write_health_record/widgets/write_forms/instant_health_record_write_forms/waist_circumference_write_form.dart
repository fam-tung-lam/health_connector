import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for waist circumference records.
@immutable
final class WaistCircumferenceWriteForm extends InstantHealthRecordWriteForm {
  const WaistCircumferenceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.waistCircumference);

  @override
  WaistCircumferenceFormState createState() => WaistCircumferenceFormState();
}

/// State for waist circumference form widget.
final class WaistCircumferenceFormState
    extends InstantHealthRecordFormState<WaistCircumferenceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return WaistCircumferenceRecord(
      time: startDateTime!,
      circumference: value! as Length,
      metadata: metadata,
    );
  }
}
