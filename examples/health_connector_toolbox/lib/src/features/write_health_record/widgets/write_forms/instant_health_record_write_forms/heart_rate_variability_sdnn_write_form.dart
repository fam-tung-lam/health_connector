import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for heart rate variability SDNN records.
@immutable
final class HeartRateVariabilitySDNNWriteForm
    extends InstantHealthRecordWriteForm {
  const HeartRateVariabilitySDNNWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.heartRateVariabilitySDNN);

  @override
  HeartRateVariabilitySDNNFormState createState() =>
      HeartRateVariabilitySDNNFormState();
}

/// State for heart rate variability SDNN form widget.
final class HeartRateVariabilitySDNNFormState
    extends InstantHealthRecordFormState<HeartRateVariabilitySDNNWriteForm> {
  @override
  HealthRecord buildRecord() {
    return HeartRateVariabilitySDNNRecord(
      time: startDateTime!,
      heartRateVariabilitySDNN: value! as Number,
      metadata: metadata,
    );
  }
}
