import 'package:flutter/material.dart';

/// A generic list widget for displaying timestamped samples with indexed items.
///
/// This widget provides a reusable, type-safe list display for any sample type,
/// with consistent styling for empty states, titles, and indexed items.
///
/// Example usage:
/// ```dart
/// SamplesList<HeartRateMeasurement>(
///   title: 'Heart Rate Samples',
///   samples: measurements,
///   itemBuilder: (sample, index) => Row(
///     children: [
///       Expanded(child: Text(formatDateTime(sample.time))),
///       Text('${sample.beatsPerMinute.value} BPM'),
///     ],
///   ),
/// )
/// ```
@immutable
final class HealthSeriesRecordSampleList<T> extends StatelessWidget {
  const HealthSeriesRecordSampleList({
    required this.title,
    required this.samples,
    required this.itemBuilder,
    super.key,
    this.emptyMessage = 'No samples available',
  });

  /// The title displayed above the samples list.
  final String title;

  /// The list of samples to display.
  final List<T> samples;

  /// Builder function for each item in the list.
  ///
  /// Receives the sample and its index (0-based).
  final Widget Function(T sample, int index) itemBuilder;

  /// Message displayed when the samples list is empty.
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          emptyMessage,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...samples.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(
                  '${entry.key + 1}.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: itemBuilder(entry.value, entry.key)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
