import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for blood glucose records.
@immutable
final class BloodGlucoseWriteForm extends InstantHealthRecordWriteForm {
  const BloodGlucoseWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bloodGlucose);

  @override
  BloodGlucoseFormState createState() => BloodGlucoseFormState();
}

/// State for blood glucose form widget.
final class BloodGlucoseFormState
    extends InstantHealthRecordFormState<BloodGlucoseWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BloodGlucoseRecord(
      time: startDateTime!,
      bloodGlucose: value! as BloodGlucose,
      metadata: metadata,
    );
  }
}
