import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/start_date_time_picker_with_duration_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/duration_picker_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Base widget for interval health record forms.
@immutable
abstract class IntervalHealthRecordWriteForm extends BaseHealthRecordWriteForm {
  const IntervalHealthRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  IntervalHealthRecordFormState createState();
}

abstract class IntervalHealthRecordFormState<
  T extends IntervalHealthRecordWriteForm
>
    extends BaseHealthRecordWriteFormState<T>
    with StartDateTimePickerWithDurationPageStateMixin<T> {
  /// The main value for this interval record (e.g., step count, distance).
  MeasurementUnit? value;

  @mustCallSuper
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      DurationPickerField(
        initialValue: duration,
        onChanged: setDuration,
        validator: durationValidator,
      ),
    ];
  }
}
