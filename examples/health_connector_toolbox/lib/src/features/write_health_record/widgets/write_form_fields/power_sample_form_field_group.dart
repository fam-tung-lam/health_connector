import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    as hc
    show PowerMeasurement, Power;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/record_sample_form_field_group.dart';

/// A form field widget for managing multiple power measurement samples.
@immutable
final class PowerSampleWriteFormFieldGroup extends StatelessWidget {
  const PowerSampleWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<hc.PowerMeasurement>?> onChanged;
  final List<hc.PowerMeasurement>? initialSamples;
  final String? Function(List<hc.PowerMeasurement>?)? validator;

  @override
  Widget build(BuildContext context) {
    return RecordSampleFormFieldGroup<hc.PowerMeasurement, double>(
      title: AppTexts.powerSamples,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 100.0,
      valueInputBuilder: (index, power, onPowerChanged) {
        return TextFormField(
          initialValue: power?.toStringAsFixed(1),
          decoration: const InputDecoration(
            labelText: '${AppTexts.power} (W)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.power),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) {
            final parsedPower = double.tryParse(value);
            if (parsedPower != null) {
              onPowerChanged(parsedPower);
            }
          },
        );
      },
      sampleFactory: (time, _, power) => hc.PowerMeasurement(
        time: time,
        power: hc.Power.watts(power),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.power.inWatts,
      ),
      valueValidator: (power) => power != null && power > 0,
    );
  }
}
