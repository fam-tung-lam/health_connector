import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/record_sample_form_field_group.dart';

/// A form field widget for managing multiple steps cadence measurement samples.
@immutable
final class StepsCadenceMeasurementsWriteFormFieldGroup
    extends StatelessWidget {
  const StepsCadenceMeasurementsWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<StepsCadenceSample>?> onChanged;
  final List<StepsCadenceSample>? initialSamples;
  final String? Function(List<StepsCadenceSample>?)? validator;

  @override
  Widget build(BuildContext context) {
    return RecordSampleFormFieldGroup<StepsCadenceSample, double>(
      title: '${AppTexts.stepsCadence} ${AppTexts.samples}',
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 100.0,
      valueInputBuilder: (index, stepsPerMinute, onValueChanged) {
        return TextFormField(
          initialValue: stepsPerMinute?.toString() ?? '100',
          decoration: const InputDecoration(
            labelText: '${AppTexts.sample} (${AppTexts.stepsPerMinute})',
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.speed),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) {
            final parsedValue = double.tryParse(value);
            if (parsedValue != null) {
              onValueChanged(parsedValue);
            }
          },
        );
      },
      sampleFactory: (time, _, stepsPerMinute) => StepsCadenceSample(
        time: time,
        cadence: Frequency.perMinute(stepsPerMinute),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.cadence.inPerMinute,
      ),
      valueValidator: (val) => val != null && val >= 0,
    );
  }
}
