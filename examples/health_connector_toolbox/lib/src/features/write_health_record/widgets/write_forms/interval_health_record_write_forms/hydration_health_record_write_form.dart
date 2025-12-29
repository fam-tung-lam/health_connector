import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for hydration records.
@immutable
final class HydrationWriteForm extends IntervalHealthRecordWriteForm {
  const HydrationWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  HydrationFormState createState() => HydrationFormState();
}

/// State for hydration form widget.
final class HydrationFormState
    extends IntervalHealthRecordFormState<HydrationWriteForm> {
  @override
  HealthRecord buildRecord() {
    return HydrationRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      volume: value! as Volume,
      metadata: metadata,
    );
  }
}
