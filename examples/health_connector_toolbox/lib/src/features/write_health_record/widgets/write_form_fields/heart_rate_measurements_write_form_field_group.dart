import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HeartRateMeasurement, Number;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/record_sample_form_field_group.dart';

/// A form field widget for managing multiple heart rate measurement samples.
@immutable
final class HeartRateMeasurementsWriteFormFieldGroup extends StatelessWidget {
  const HeartRateMeasurementsWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<HeartRateMeasurement>?> onChanged;
  final List<HeartRateMeasurement>? initialSamples;
  final String? Function(List<HeartRateMeasurement>?)? validator;

  @override
  Widget build(BuildContext context) {
    return RecordSampleFormFieldGroup<HeartRateMeasurement, int>(
      title: AppTexts.heartRateSamples,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 72,
      valueInputBuilder: (index, bpm, onBpmChanged) {
        return TextFormField(
          initialValue: bpm?.toString() ?? '72',
          decoration: const InputDecoration(
            labelText: AppTexts.sampleBpm,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.numbers),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final parsedBpm = int.tryParse(value);
            if (parsedBpm != null) {
              onBpmChanged(parsedBpm);
            }
          },
        );
      },
      sampleFactory: (time, _, bpm) => HeartRateMeasurement(
        time: time,
        beatsPerMinute: Number(bpm),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.beatsPerMinute.value as int,
      ),
      valueValidator: (bpm) => bpm != null && bpm > 0,
    );
  }
}
