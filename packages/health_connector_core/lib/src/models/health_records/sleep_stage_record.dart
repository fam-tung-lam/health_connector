part of 'health_record.dart';

/// Represents a single sleep stage measurement.
///
/// **Platform:** iOS only
///
/// A complete night's sleep consists of multiple records, one for each stage
/// transition.
///
/// This maps directly to iOS's `HKCategorySample` with `.sleepAnalysis` type.
///
/// ## Example
/// ```dart
/// final record = SleepStageRecord(
///   id: HealthRecordId('ABC-123'),
///   startTime: DateTime(2024, 1, 15, 22, 0),
///   endTime: DateTime(2024, 1, 15, 22, 30),
///   stage: SleepStage(
///     startTime: DateTime(2024, 1, 15, 22, 0),
///     endTime: DateTime(2024, 1, 15, 22, 30),
///     stageType: SleepStageType.light,
///   ),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.apple.health'),
///   ),
/// );
/// ```
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class SleepStageRecord extends IntervalHealthRecord {
  const SleepStageRecord({
    required super.id,
    required super.metadata,
    required super.startTime,
    required super.endTime,
    required this.stageType,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// The sleep stage for this record.
  ///
  /// Each record represents a single continuous period in one stage.
  final SleepStageType stageType;

  /// Optional user-defined title for the sleep stage.
  ///
  /// Example: "Night Sleep", "Afternoon Nap"
  final String? title;

  /// Optional user-defined notes about the sleep stage.
  ///
  /// Example: "Felt well-rested", "Woke up multiple times"
  final String? notes;

  /// Whether this stage represents actual sleep (vs awake/in-bed).
  ///
  /// Returns `false` for: awake, outOfBed, inBed
  /// Returns `true` for: sleeping, light, deep, rem
  bool get isActualSleep {
    const awakeSleepStages = {
      SleepStageType.awake,
      SleepStageType.outOfBed,
      SleepStageType.inBed,
    };
    return !awakeSleepStages.contains(stageType);
  }

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          stageType == other.stageType;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      stageType.hashCode;
}
