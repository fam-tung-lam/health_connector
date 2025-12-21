import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HeartRateMeasurement;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_format_utils.dart';

/// Widget that displays a list of heart rate measurement samples.
///
/// Shows each sample with its time and BPM value in a clean list format.
@immutable
final class HeartRateSamplesList extends StatelessWidget {
  const HeartRateSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of heart rate measurements to display.
  final List<HeartRateMeasurement> samples;

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No samples available',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppTexts.heartRateSamples,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...samples.asMap().entries.map((entry) {
          final index = entry.key;
          final sample = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(
                  '${index + 1}.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormatUtils.formatDateTime(sample.time),
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Text(
                  '${sample.beatsPerMinute.value} '
                  '${AppTexts.heartRateLabel}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
