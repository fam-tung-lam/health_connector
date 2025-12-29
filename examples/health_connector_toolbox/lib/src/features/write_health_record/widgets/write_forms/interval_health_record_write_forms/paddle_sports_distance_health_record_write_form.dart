import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for paddle sports distance records.
@immutable
final class PaddleSportsDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const PaddleSportsDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  PaddleSportsDistanceFormState createState() =>
      PaddleSportsDistanceFormState();
}

/// State for paddle sports distance form widget.
final class PaddleSportsDistanceFormState
    extends IntervalHealthRecordFormState<PaddleSportsDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PaddleSportsDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
