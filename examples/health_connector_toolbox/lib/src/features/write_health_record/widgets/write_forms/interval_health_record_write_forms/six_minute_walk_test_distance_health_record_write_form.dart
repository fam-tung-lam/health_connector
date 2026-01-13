import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
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
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.sixMinuteWalkTestDistance,
        onChanged: (MeasurementUnit? newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    ];
  }

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
