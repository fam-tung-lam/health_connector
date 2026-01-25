import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for basal metabolic rate records.
@immutable
final class BasalMetabolicRateWriteForm extends InstantHealthRecordWriteForm {
  const BasalMetabolicRateWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.basalMetabolicRate);

  @override
  BasalMetabolicRateFormState createState() => BasalMetabolicRateFormState();
}

/// State for basal metabolic rate form widget.
final class BasalMetabolicRateFormState
    extends InstantHealthRecordFormState<BasalMetabolicRateWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BasalMetabolicRateRecord(
      time: startDateTime!,
      rate: value! as Power,
      metadata: metadata,
    );
  }
}
