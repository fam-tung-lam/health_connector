part of '../health_record.dart';

/// Represents a complete sleep session.
///
/// A sleep session is a container with a time range and multiple sleep stages.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SleepSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepSessionRecord)
/// - **iOS HealthKit**: Not supported (Use [SleepStageRecord])
///
/// ## Example
///
/// ```dart
/// final session = SleepSessionRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime(2024, 1, 15, 22, 0),
///   endTime: DateTime(2024, 1, 16, 6, 30),
///   title: 'Night Sleep',
///   samples: [
///     SleepStageSample(
///       startTime: DateTime(2024, 1, 15, 22, 0),
///       endTime: DateTime(2024, 1, 15, 22, 30),
///       stageType: SleepStageType.light,
///     ),
///     SleepStageSample(
///       startTime: DateTime(2024, 1, 15, 22, 30),
///       endTime: DateTime(2024, 1, 16, 1, 0),
///       stageType: SleepStageType.deep,
///     ),
///     // ... more stages
///   ],
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [SleepSessionDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepSessionRecord extends SeriesHealthRecord<SleepStageSample> {
  /// Minimum valid sleep session duration (1 minute).
  ///
  /// Brief naps; shorter than 1 minute unlikely to be actual sleep.
  static const Duration minDuration = Duration(minutes: 1);

  /// Maximum valid sleep session duration (24 hours).
  ///
  /// Typical sleep duration 4-12 hours; 24 hours allows for extended sleep or
  /// combined sessions.
  static const Duration maxDuration = Duration(hours: 24);

  /// Creates a sleep session record.
  ///
  /// The session spans from [startTime] to [endTime] and contains a list of
  /// [samples] (sleep stages).
  ///
  /// Optional [title] and [notes] can be provided. Use [metadata] to describe
  /// the data source. Timezone offsets can be provided via
  /// [startZoneOffsetSeconds] and [endZoneOffsetSeconds].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if session duration is outside the valid range of
  ///   [minDuration] to [maxDuration].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minDuration])**: Brief naps; shorter than 1 minute
  ///   unlikely to be actual sleep.
  /// - **Maximum ([maxDuration])**: Typical sleep duration 4-12 hours; 24
  ///   hours allows for extended sleep or combined sessions.
  SleepSessionRecord({
    required super.id,
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    final duration = endTime.difference(startTime);
    require(
      condition: duration >= minDuration && duration <= maxDuration,
      value: duration,
      name: 'sleep session duration',
      message:
          'Sleep session duration must be between ${minDuration.inMinutes} '
          'minute(s) and ${maxDuration.inHours} hours. '
          'Got ${duration.inMinutes} minutes.',
    );
  }

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory SleepSessionRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<SleepStageSample> samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return SleepSessionRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      title: title,
      notes: notes,
    );
  }

  SleepSessionRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// Optional user-defined title for the sleep session.
  ///
  /// Example: "Night Sleep", "Afternoon Nap"
  final String? title;

  /// Optional user-defined notes about the sleep session.
  ///
  /// Example: "Felt well-rested", "Woke up multiple times"
  final String? notes;

  /// The total duration spent actually sleeping (excluding awake stages).
  ///
  /// This sums the duration of all stages except:
  /// - [SleepStage.awake]
  /// - [SleepStage.outOfBed]
  /// - [SleepStage.inBed]
  Duration get totalSleepDuration {
    const awakeSleepStages = {
      SleepStage.awake,
      SleepStage.outOfBed,
      SleepStage.inBed,
    };

    return samples
        .where((stage) => !awakeSleepStages.contains(stage.stageType))
        .fold(Duration.zero, (total, stage) => total + stage.duration);
  }

  /// Creates a copy with the given fields replaced with the new values.
  SleepSessionRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<SleepStageSample>? samples,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return SleepSessionRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      samples: samples ?? this.samples,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepSessionRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          title == other.title &&
          notes == other.notes &&
          const ListEquality<SleepStageSample>().equals(
            samples,
            other.samples,
          );

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      title.hashCode ^
      notes.hashCode ^
      const ListEquality<SleepStageSample>().hash(samples);
}

/// Represents a single sleep stage period with time range.
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepStageSample {
  /// Creates a sleep stage.
  ///
  /// The stage is defined by [startTime], [endTime], and the [stageType].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  SleepStageSample({
    required DateTime startTime,
    required DateTime endTime,
    required this.stageType,
  }) : startTime = startTime.toUtc(),
       endTime = endTime.toUtc() {
    require(
      condition: endTime.isAfter(startTime),
      value: endTime,
      name: 'endTime',
      message: 'Sleep stage end time must be after start time.',
    );
  }

  /// The start time of this sleep stage, stored as a UTC instant.
  ///
  /// To interpret this value in the user's local (civil) time, use the zone
  /// offset information from the parent [SleepSessionRecord].
  final DateTime startTime;

  /// The end time of this sleep stage, stored as a UTC instant.
  ///
  /// To interpret this value in the user's local (civil) time, use the zone
  /// offset information from the parent [SleepSessionRecord].
  final DateTime endTime;

  /// The type of sleep stage.
  final SleepStage stageType;

  /// The duration of this sleep stage.
  Duration get duration => endTime.difference(startTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageSample &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          stageType == other.stageType;

  @override
  int get hashCode =>
      startTime.hashCode ^ endTime.hashCode ^ stageType.hashCode;
}
