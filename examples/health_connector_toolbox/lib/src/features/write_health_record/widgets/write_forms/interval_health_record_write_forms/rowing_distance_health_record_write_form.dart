import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for rowing distance records.
@immutable
final class RowingDistanceWriteForm extends IntervalHealthRecordWriteForm {
  const RowingDistanceWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  RowingDistanceFormState createState() => RowingDistanceFormState();
}

/// State for rowing distance form widget.
final class RowingDistanceFormState
    extends IntervalHealthRecordFormState<RowingDistanceWriteForm> {
  @override
  HealthRecord buildRecord() {
    return RowingDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
