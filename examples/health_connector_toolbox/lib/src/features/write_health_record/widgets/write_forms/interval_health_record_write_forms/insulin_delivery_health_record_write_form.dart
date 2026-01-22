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
  InsulinDeliveryReason _reason = InsulinDeliveryReason.basal;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      DropdownButtonFormField<InsulinDeliveryReason>(
        initialValue: _reason,
        decoration: const InputDecoration(
          labelText: 'Reason',
          border: OutlineInputBorder(),
        ),
        items: InsulinDeliveryReason.values
            .map(
              (reason) => DropdownMenuItem(
                value: reason,
                child: Text(reason.name.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _reason = newValue;
            });
          }
        },
      ),
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
      reason: _reason,
      metadata: metadata,
    );
  }
}
