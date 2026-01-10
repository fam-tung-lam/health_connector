import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HeartRateMeasurement;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of heart rate measurement samples.
///
/// Shows each sample with its time and BPM value in a clean list format.
@immutable
final class HeartRateSeriesRecordHeartRateMeasurementList
    extends StatelessWidget {
  const HeartRateSeriesRecordHeartRateMeasurementList({
    required this.samples,
    super.key,
  });

  /// The list of heart rate measurements to display.
  final List<HeartRateMeasurement> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<HeartRateMeasurement>(
      title: AppTexts.heartRateSamples,
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label: DateFormatter.formatDateTime(sample.time),
        value:
            '${sample.rate.inPerMinute.toStringAsFixed(0)} '
            '${AppTexts.bpm}',
      ),
    );
  }
}
