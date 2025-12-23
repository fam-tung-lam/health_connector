part of '../health_record.dart';

/// Represents a complete sleep session (Android Health Connect).
///
/// **Platform:** Android Health Connect Only
///
/// A sleep session is a container with a time range and multiple sleep stages.
/// This maps directly to Android's `SleepSessionRecord` with embedded stages.
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
///     SleepStage(
///       startTime: DateTime(2024, 1, 15, 22, 0),
///       endTime: DateTime(2024, 1, 15, 22, 30),
///       stageType: SleepStageType.light,
///     ),
///     SleepStage(
///       startTime: DateTime(2024, 1, 15, 22, 30),
///       endTime: DateTime(2024, 1, 16, 1, 0),
///       stageType: SleepStageType.deep,
///     ),
///     // ... more stages
///   ],
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepSessionRecord extends SeriesHealthRecord<SleepStage> {
  /// Creates a sleep session record.
  ///
  /// The session spans from [startTime] to [endTime] and contains a list of
  /// [samples] (sleep stages).
  ///
  /// Optional [title] and [notes] can be provided. Use [metadata] to describe
  /// the data source. Timezone offsets can be provided via
  /// [startZoneOffsetSeconds] and [endZoneOffsetSeconds].
  const SleepSessionRecord({
    required super.id,
    required super.metadata,
    required super.startTime,
    required super.endTime,
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
  /// - [SleepStageType.awake]
  /// - [SleepStageType.outOfBed]
  /// - [SleepStageType.inBed]
  Duration get totalSleepDuration {
    const awakeSleepStages = {
      SleepStageType.awake,
      SleepStageType.outOfBed,
      SleepStageType.inBed,
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
    List<SleepStage>? samples,
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
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

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
          samples.equals(other.samples);

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
      Object.hashAll(samples);
}

/// Represents a single sleep stage period with time range.
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepStage {
  /// Creates a sleep stage.
  ///
  /// The stage is defined by [startTime], [endTime], and the [stageType].
  const SleepStage({
    required this.startTime,
    required this.endTime,
    required this.stageType,
  });

  /// The start time of this sleep stage.
  final DateTime startTime;

  /// The end time of this sleep stage.
  final DateTime endTime;

  /// The type of sleep stage.
  final SleepStageType stageType;

  /// The duration of this sleep stage.
  Duration get duration => endTime.difference(startTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStage &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          stageType == other.stageType;

  @override
  int get hashCode =>
      startTime.hashCode ^ endTime.hashCode ^ stageType.hashCode;
}
