import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for weight records.
///
/// This is a simple instant record with a single value field (Mass).
/// Uses the default implementation from InstantHealthRecordFormState.
@immutable
final class WeightWriteForm extends InstantHealthRecordWriteForm {
  const WeightWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.weight);

  @override
  WeightFormState createState() => WeightFormState();
}

/// State for weight form widget.
///
/// Uses the default single-value field implementation from the base class.
final class WeightFormState
    extends InstantHealthRecordFormState<WeightWriteForm> {
  @override
  HealthRecord buildRecord() {
    return WeightRecord(
      time: startDateTime!,
      weight: value! as Mass,
      metadata: metadata,
    );
  }
}
