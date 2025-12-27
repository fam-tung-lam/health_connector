import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show PowerMeasurement;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of power measurements.
///
/// Shows each sample with its time and power value in a clean list format.
@immutable
final class PowerSeriesRecordSamplesList extends StatelessWidget {
  const PowerSeriesRecordSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of power measurements to display.
  final List<PowerMeasurement> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<PowerMeasurement>(
      title: AppTexts.powerSamples,
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label: DateFormatter.formatDateTime(sample.time),
        value: '${sample.power.inWatts.toStringAsFixed(1)} W',
      ),
    );
  }
}
