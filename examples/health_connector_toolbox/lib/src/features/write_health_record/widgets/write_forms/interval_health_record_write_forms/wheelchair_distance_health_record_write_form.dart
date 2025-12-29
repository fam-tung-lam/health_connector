import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for wheelchair distance records.
@immutable
final class WheelchairDistanceWriteForm extends IntervalHealthRecordWriteForm {
  const WheelchairDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  WheelchairDistanceFormState createState() => WheelchairDistanceFormState();
}

/// State for wheelchair distance form widget.
final class WheelchairDistanceFormState
    extends IntervalHealthRecordFormState<WheelchairDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return WheelchairDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
