import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for body mass index records.
@immutable
final class BodyMassIndexWriteForm extends InstantHealthRecordWriteForm {
  const BodyMassIndexWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bodyMassIndex);

  @override
  BodyMassIndexFormState createState() => BodyMassIndexFormState();
}

/// State for body mass index form widget.
final class BodyMassIndexFormState
    extends InstantHealthRecordFormState<BodyMassIndexWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BodyMassIndexRecord(
      time: startDateTime!,
      bmi: value! as Number,
      metadata: metadata,
    );
  }
}
