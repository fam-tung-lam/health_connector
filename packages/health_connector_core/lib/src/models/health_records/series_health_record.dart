part of 'health_record.dart';

/// Base health record class containing multiple data samples within a
/// time interval.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class SeriesHealthRecord<T> extends IntervalHealthRecord {
  /// Creates an instance of [SeriesHealthRecord].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  SeriesHealthRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The list of data samples within this time interval.
  ///
  /// Each sample represents a timestamped measurement taken during the interval
  /// from [startTime] to [endTime].
  final List<T> samples;

  /// The number of samples in this series record.
  int get samplesCount => samples.length;
}
