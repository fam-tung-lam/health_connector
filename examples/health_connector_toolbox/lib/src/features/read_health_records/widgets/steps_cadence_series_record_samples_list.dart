import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show StepsCadenceSample;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of steps cadence measurements.
///
/// Shows each sample with its time and steps/min value in a clean list format.
@immutable
final class StepsCadenceSeriesRecordSamplesList extends StatelessWidget {
  const StepsCadenceSeriesRecordSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of steps cadence measurements to display.
  final List<StepsCadenceSample> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<StepsCadenceSample>(
      title: '${AppTexts.stepsCadence} ${AppTexts.samples}',
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label: DateFormatter.formatDateTime(sample.time),
        value: '${sample.cadence.inPerMinute} ${AppTexts.stepsPerMinute}',
      ),
    );
  }
}
