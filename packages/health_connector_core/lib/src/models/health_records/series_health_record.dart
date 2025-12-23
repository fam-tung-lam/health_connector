part of 'health_record.dart';

/// A health record containing multiple data samples within a time interval.
///
/// ## Platform Behavior
///
/// ### Android Health Connect
/// - Native support for series records
/// - Maps to `SeriesRecord` subclasses
/// - Samples stored as part of the record
/// - Efficient bulk storage and retrieval
///
/// ### iOS HealthKit
/// - Series represented via `HKQuantitySeries` or multiple `HKQuantitySample`
/// - Less direct support compared to Android
/// - May require aggregation of individual samples
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class SeriesHealthRecord<T> extends IntervalHealthRecord {
  /// Constructor for subclasses.
  const SeriesHealthRecord({
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
