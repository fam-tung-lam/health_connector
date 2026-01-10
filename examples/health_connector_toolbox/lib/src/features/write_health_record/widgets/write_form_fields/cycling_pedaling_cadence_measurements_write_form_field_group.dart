import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/record_sample_form_field_group.dart';

/// A form field widget for managing multiple cycling pedaling cadence
/// measurement samples.
@immutable
final class CyclingPedalingCadenceMeasurementsWriteFormFieldGroup
    extends StatelessWidget {
  const CyclingPedalingCadenceMeasurementsWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<CyclingPedalingCadenceSample>?> onChanged;
  final List<CyclingPedalingCadenceSample>? initialSamples;
  final String? Function(List<CyclingPedalingCadenceSample>?)? validator;

  @override
  Widget build(BuildContext context) {
    return RecordSampleFormFieldGroup<CyclingPedalingCadenceSample, int>(
      title: AppTexts.cyclingPedalingCadenceSamples,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 60,
      valueInputBuilder: (index, rpm, onRpmChanged) {
        return TextFormField(
          initialValue: rpm?.toString() ?? '60',
          decoration: const InputDecoration(
            labelText: AppTexts.sampleRpm,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.numbers),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final parsedRpm = int.tryParse(value);
            if (parsedRpm != null) {
              onRpmChanged(parsedRpm);
            }
          },
        );
      },
      sampleFactory: (time, _, rpm) => CyclingPedalingCadenceSample(
        time: time,
        cadence: Frequency.perMinute(rpm.toDouble()),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.cadence.inPerMinute.toInt(),
      ),
      valueValidator: (rpm) => rpm != null && rpm > 0,
    );
  }
}
