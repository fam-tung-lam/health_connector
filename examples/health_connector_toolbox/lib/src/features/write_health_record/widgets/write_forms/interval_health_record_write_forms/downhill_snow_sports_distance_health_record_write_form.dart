import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
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
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.downhillSnowSportsDistance,
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
    return DownhillSnowSportsDistanceRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      distance: value! as Length,
      metadata: metadata,
    );
  }
}
