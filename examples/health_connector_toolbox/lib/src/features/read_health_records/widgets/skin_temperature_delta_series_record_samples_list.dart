import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show SkinTemperatureDeltaSample;
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of skin temperature delta measurements.
///
/// Shows each sample with its time and temperature delta value in a clean list
/// format.
@immutable
final class SkinTemperatureDeltaSeriesRecordSamplesList
    extends StatelessWidget {
  const SkinTemperatureDeltaSeriesRecordSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of skin temperature delta measurements to display.
  final List<SkinTemperatureDeltaSample> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<SkinTemperatureDeltaSample>(
      title: 'Temperature Delta Samples',
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label: DateFormatter.formatDateTime(sample.time),
        value:
            '${sample.temperatureDelta.inCelsius >= 0 ? '+' : ''}'
            '${sample.temperatureDelta.inCelsius.toStringAsFixed(2)}°C',
      ),
    );
  }
}
