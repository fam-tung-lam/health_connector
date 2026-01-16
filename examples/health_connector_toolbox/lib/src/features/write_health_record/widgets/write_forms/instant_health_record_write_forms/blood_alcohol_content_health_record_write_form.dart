import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for blood alcohol content records.
@immutable
final class BloodAlcoholContentWriteForm extends InstantHealthRecordWriteForm {
  const BloodAlcoholContentWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bloodAlcoholContent);

  @override
  BloodAlcoholContentFormState createState() => BloodAlcoholContentFormState();
}

/// State for body fat percentage form widget.
final class BloodAlcoholContentFormState
    extends InstantHealthRecordFormState<BloodAlcoholContentWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BloodAlcoholContentRecord(
      time: startDateTime!,
      percentage: value! as Percentage,
      metadata: metadata,
    );
  }
}
