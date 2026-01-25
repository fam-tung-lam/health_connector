import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    as hc
    show SkinTemperatureDeltaSample, Temperature;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/record_sample_form_field_group.dart';

/// A form field widget for managing multiple skin temperature delta measurement
/// samples.
@immutable
final class SkinTemperatureDeltaSampleWriteFormFieldGroup
    extends StatelessWidget {
  const SkinTemperatureDeltaSampleWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<hc.SkinTemperatureDeltaSample>?> onChanged;
  final List<hc.SkinTemperatureDeltaSample>? initialSamples;
  final String? Function(List<hc.SkinTemperatureDeltaSample>?)? validator;

  @override
  Widget build(BuildContext context) {
    return RecordSampleFormFieldGroup<hc.SkinTemperatureDeltaSample, double>(
      title: 'Temperature Delta Samples',
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 0.0,
      valueInputBuilder: (index, delta, onDeltaChanged) {
        return TextFormField(
          initialValue: delta?.toStringAsFixed(2),
          decoration: const InputDecoration(
            labelText: 'Temperature Delta (°C)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.temperature),
            helperText: 'Range: -30.0 to 30.0°C',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) {
            final parsedDelta = double.tryParse(value);
            if (parsedDelta != null) {
              onDeltaChanged(parsedDelta);
            }
          },
        );
      },
      sampleFactory: (time, _, delta) => hc.SkinTemperatureDeltaSample(
        time: time,
        temperatureDelta: hc.Temperature.celsius(delta),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.temperatureDelta.inCelsius,
      ),
      valueValidator: (delta) =>
          delta != null && delta >= -30.0 && delta <= 30.0,
    );
  }
}
