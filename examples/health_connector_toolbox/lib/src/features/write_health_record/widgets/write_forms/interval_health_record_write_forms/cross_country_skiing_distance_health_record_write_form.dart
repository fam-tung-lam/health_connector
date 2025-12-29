import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for cross country skiing distance records.
@immutable
final class CrossCountrySkiingDistanceWriteForm
    extends IntervalHealthRecordWriteForm {
  const CrossCountrySkiingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CrossCountrySkiingDistanceFormState createState() =>
      CrossCountrySkiingDistanceFormState();
}

/// State for cross country skiing distance form widget.
final class CrossCountrySkiingDistanceFormState
    extends IntervalHealthRecordFormState<CrossCountrySkiingDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CrossCountrySkiingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
