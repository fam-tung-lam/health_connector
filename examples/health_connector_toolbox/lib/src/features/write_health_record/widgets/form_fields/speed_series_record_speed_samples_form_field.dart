import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    as hc
    show SpeedMeasurement, Velocity;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/series_health_record_samples_form_field.dart';

/// A form field widget for managing multiple speed measurement samples.
///
/// Now uses the generic [SeriesHealthRecordSamplesFormField] widget
/// to eliminate duplication.
@immutable
final class SpeedSeriesRecordSpeedSamplesFormField extends StatelessWidget {
  const SpeedSeriesRecordSpeedSamplesFormField({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<hc.SpeedMeasurement>?> onChanged;
  final List<hc.SpeedMeasurement>? initialSamples;
  final String? Function(List<hc.SpeedMeasurement>?)? validator;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordSamplesFormField<hc.SpeedMeasurement, double>(
      title: AppTexts.speedSamples,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: 1.0,
      valueInputBuilder: (index, speed, onSpeedChanged) {
        return TextFormField(
          initialValue: speed?.toStringAsFixed(2),
          decoration: InputDecoration(
            labelText: AppTexts.withUnit(
              AppTexts.speed,
              AppTexts.metersPerSecond,
            ),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(AppIcons.speed),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) {
            final parsedSpeed = double.tryParse(value);
            if (parsedSpeed != null) {
              onSpeedChanged(parsedSpeed);
            }
          },
        );
      },
      sampleFactory: (time, _, speed) => hc.SpeedMeasurement(
        time: time,
        speed: hc.Velocity.metersPerSecond(speed),
      ),
      sampleExtractor: (sample) => (
        time: sample.time,
        endTime: null as DateTime?,
        value: sample.speed.inMetersPerSecond,
      ),
      valueValidator: (speed) => speed != null && speed > 0,
    );
  }
}
