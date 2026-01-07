import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for heart rate measurement records.
@immutable
final class HeartRateMeasurementWriteForm extends InstantHealthRecordWriteForm {
  const HeartRateMeasurementWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.heartRateMeasurementRecord);

  @override
  HeartRateMeasurementFormState createState() =>
      HeartRateMeasurementFormState();
}

/// State for heart rate measurement form widget.
final class HeartRateMeasurementFormState
    extends InstantHealthRecordFormState<HeartRateMeasurementWriteForm> {
  @override
  HealthRecord buildRecord() {
    return HeartRateMeasurementRecord(
      id: HealthRecordId.none,
      time: startDateTime!,
      beatsPerMinute: value! as Number,
      metadata: metadata,
    );
  }
}
