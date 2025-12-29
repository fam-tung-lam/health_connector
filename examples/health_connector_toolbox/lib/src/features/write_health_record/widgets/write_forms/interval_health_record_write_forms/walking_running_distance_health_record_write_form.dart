import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for walking/running distance records.
@immutable
final class WalkingRunningDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const WalkingRunningDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  WalkingRunningDistanceFormState createState() =>
      WalkingRunningDistanceFormState();
}

/// State for walking/running distance form widget.
final class WalkingRunningDistanceFormState
    extends IntervalHealthRecordFormState<WalkingRunningDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return WalkingRunningDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
