import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show SpeedMeasurement;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of speed measurements.
///
/// Shows each sample with its time and speed value in a clean list format.
@immutable
final class SpeedSeriesRecordSamplesList extends StatelessWidget {
  const SpeedSeriesRecordSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of speed measurements to display.
  final List<SpeedMeasurement> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<SpeedMeasurement>(
      title: AppTexts.speedSamples,
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label: DateFormatter.formatDateTime(sample.time),
        value: '${sample.speed.inMetersPerSecond.toStringAsFixed(2)} m/s',
      ),
    );
  }
}
