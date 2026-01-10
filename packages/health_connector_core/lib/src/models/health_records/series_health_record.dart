part of 'health_record.dart';

/// Base health record class containing multiple data samples within a
/// time interval.
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class SeriesHealthRecord<T> extends IntervalHealthRecord {
  /// Constructor for subclasses.
  SeriesHealthRecord({
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<T> samples,
    HealthRecordId id = HealthRecordId.none,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) : this._(
         startTime: startTime,
         endTime: endTime,
         metadata: metadata,
         samples: samples,
         id: id,
         startZoneOffsetSeconds: startZoneOffsetSeconds,
         endZoneOffsetSeconds: endZoneOffsetSeconds,
       );

  /// Private constructor for internal use that skips validation.
  SeriesHealthRecord._({
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
