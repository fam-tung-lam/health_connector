import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Write form for electrodermal activity records.
final class ElectrodermalActivityWriteForm
    extends IntervalHealthRecordWriteForm {
  const ElectrodermalActivityWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ElectrodermalActivityFormState createState() =>
      ElectrodermalActivityFormState();
}

/// State for electrodermal activity write form.
final class ElectrodermalActivityFormState
    extends IntervalHealthRecordFormState<ElectrodermalActivityWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.electrodermalActivity,
        onChanged: (MeasurementUnit? newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    ];
  }

  @override
  bool validate() {
    if (!super.validate()) {
      return false;
    }
    if (value != null) {
      final conductance = value! as Number;
      if (conductance < ElectrodermalActivityRecord.minConductance ||
          conductance > ElectrodermalActivityRecord.maxConductance) {
        showAppSnackBar(
          context,
          SnackBarType.error,
          'Conductance must be between '
          '${ElectrodermalActivityRecord.minConductance.value} and '
          '${ElectrodermalActivityRecord.maxConductance.value} μS',
        );
        return false;
      }
    }
    return true;
  }

  @override
  HealthRecord buildRecord() {
    return ElectrodermalActivityRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      conductance: value! as Number,
      metadata: metadata,
    );
  }
}
