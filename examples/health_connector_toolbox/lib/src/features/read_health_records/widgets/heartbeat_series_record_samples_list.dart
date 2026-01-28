import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HeartbeatSample;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_series_record_samples_list.dart';

/// Widget that displays a list of heartbeat samples.
///
/// Shows each sample with its offset from series start and gap indicator.
@immutable
final class HeartbeatSeriesRecordSampleList extends StatelessWidget {
  const HeartbeatSeriesRecordSampleList({
    required this.samples,
    super.key,
  });

  /// The list of heartbeat samples to display.
  final List<HeartbeatSample> samples;

  @override
  Widget build(BuildContext context) {
    return HealthSeriesRecordSampleList<HeartbeatSample>(
      title: AppTexts.heartbeatSamples,
      samples: samples,
      itemBuilder: (sample, index) => HealthRecordDetailRow(
        label:
            '${AppTexts.offsetSeconds}: '
            '${sample.timeSinceSeriesStart.inSeconds}s',
        value: sample.precededByGap
            ? '${AppTexts.precededByGap} ✓'
            : '${AppTexts.precededByGap} ✗',
      ),
    );
  }
}
