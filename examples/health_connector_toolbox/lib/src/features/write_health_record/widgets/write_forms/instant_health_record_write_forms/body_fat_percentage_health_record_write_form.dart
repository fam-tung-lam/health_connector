import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for body fat percentage records.
@immutable
final class BodyFatPercentageWriteForm extends InstantHealthRecordWriteForm {
  const BodyFatPercentageWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bodyFatPercentage);

  @override
  BodyFatPercentageFormState createState() => BodyFatPercentageFormState();
}

/// State for body fat percentage form widget.
final class BodyFatPercentageFormState
    extends InstantHealthRecordFormState<BodyFatPercentageWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BodyFatPercentageRecord(
      time: startDateTime!,
      percentage: value! as Percentage,
      metadata: metadata,
    );
  }
}
