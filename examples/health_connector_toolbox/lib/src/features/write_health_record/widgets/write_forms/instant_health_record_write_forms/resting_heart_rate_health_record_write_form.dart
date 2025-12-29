import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for resting heart rate records.
@immutable
final class RestingHeartRateWriteForm extends InstantHealthRecordWriteForm {
  const RestingHeartRateWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.restingHeartRate);

  @override
  RestingHeartRateFormState createState() => RestingHeartRateFormState();
}

/// State for resting heart rate form widget.
final class RestingHeartRateFormState
    extends InstantHealthRecordFormState<RestingHeartRateWriteForm> {
  @override
  HealthRecord buildRecord() {
    return RestingHeartRateRecord(
      time: startDateTime!,
      beatsPerMinute: value! as Number,
      metadata: metadata,
    );
  }
}
