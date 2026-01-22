import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for insulin delivery records.
@immutable
final class InsulinDeliveryWriteForm extends IntervalHealthRecordWriteForm {
  const InsulinDeliveryWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  InsulinDeliveryFormState createState() => InsulinDeliveryFormState();
}

/// State for insulin delivery form widget.
final class InsulinDeliveryFormState
    extends IntervalHealthRecordFormState<InsulinDeliveryWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.insulinDelivery,
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
    return InsulinDeliveryRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      units: value! as Number,
      metadata: metadata,
    );
  }
}
