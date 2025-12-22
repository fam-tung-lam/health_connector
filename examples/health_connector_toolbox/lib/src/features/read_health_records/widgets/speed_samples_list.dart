import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show SpeedMeasurement;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_format_utils.dart';

/// Widget that displays a list of speed measurements.
///
/// Shows each sample with its time and speed value in a clean list format.
@immutable
final class SpeedSamplesList extends StatelessWidget {
  const SpeedSamplesList({
    required this.samples,
    super.key,
  });

  /// The list of speed measurements to display.
  final List<SpeedMeasurement> samples;

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
          AppTexts.speedSamples,
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
                  '${sample.speed.inMetersPerSecond.toStringAsFixed(2)} m/s',
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
