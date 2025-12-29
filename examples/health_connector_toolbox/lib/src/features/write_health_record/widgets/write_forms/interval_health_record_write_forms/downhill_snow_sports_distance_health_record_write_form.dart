import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for downhill snow sports distance records.
@immutable
final class DownhillSnowSportsDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const DownhillSnowSportsDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  DownhillSnowSportsDistanceFormState createState() =>
      DownhillSnowSportsDistanceFormState();
}

/// State for downhill snow sports distance form widget.
final class DownhillSnowSportsDistanceFormState
    extends IntervalHealthRecordFormState<DownhillSnowSportsDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DownhillSnowSportsDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
