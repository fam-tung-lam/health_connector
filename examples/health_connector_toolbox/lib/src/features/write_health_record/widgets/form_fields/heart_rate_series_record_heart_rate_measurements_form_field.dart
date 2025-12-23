import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HeartRateMeasurement, Number;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/series_health_record_samples_form_field.dart';

/// A form field widget for managing multiple heart rate measurement samples.
///
/// Now uses the generic [SeriesHealthRecordSamplesFormField] widget
/// to eliminate duplication.
@immutable
final class HeartRateSeriesRecordHeartRateMeasurementsFormField
    extends StatelessWidget {
  const HeartRateSeriesRecordHeartRateMeasurementsFormField({
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
    return SeriesHealthRecordSamplesFormField<HeartRateMeasurement, int>(
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
