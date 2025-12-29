import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for six minute walk test distance records.
@immutable
final class SixMinuteWalkTestDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const SixMinuteWalkTestDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SixMinuteWalkTestDistanceFormState createState() =>
      SixMinuteWalkTestDistanceFormState();
}

/// State for six minute walk test distance form widget.
final class SixMinuteWalkTestDistanceFormState
    extends IntervalHealthRecordFormState<SixMinuteWalkTestDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SixMinuteWalkTestDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
