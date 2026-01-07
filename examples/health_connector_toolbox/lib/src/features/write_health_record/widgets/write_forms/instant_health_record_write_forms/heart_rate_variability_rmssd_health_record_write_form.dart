import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for heart rate variability RMSSD records.
@immutable
final class HeartRateVariabilityRMSSDWriteForm
    extends InstantHealthRecordWriteForm {
  const HeartRateVariabilityRMSSDWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.heartRateVariabilityRMSSD);

  @override
  HeartRateVariabilityRMSSDFormState createState() =>
      HeartRateVariabilityRMSSDFormState();
}

/// State for heart rate variability RMSSD form widget.
final class HeartRateVariabilityRMSSDFormState
    extends InstantHealthRecordFormState<HeartRateVariabilityRMSSDWriteForm> {
  @override
  HealthRecord buildRecord() {
    return HeartRateVariabilityRMSSDRecord(
      time: startDateTime!,
      heartRateVariabilityMillis: value! as Number,
      metadata: metadata,
    );
  }
}
