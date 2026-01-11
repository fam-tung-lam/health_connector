part of '../health_record.dart';

/// Represents a single sleep stage measurement.
///
/// A complete night's sleep consists of multiple records, one for each stage
/// transition.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SleepSessionRecord])
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.sleepAnalysis`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sleepanalysis/)
///
/// ## Example
///
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
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [SleepStageDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class SleepStageRecord extends IntervalHealthRecord {
  /// Creates a sleep stage record.
  ///
  /// The [startTime] and [endTime] define the period of the sleep stage.
  /// The [stageType] specifies the type of sleep (e.g., light, deep).
  ///
  /// Use [metadata] to describe the data source. Timezone offsets can be
  /// provided via [startZoneOffsetSeconds] and [endZoneOffsetSeconds].
  SleepStageRecord({
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

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodPressureRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory SleepStageRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required SleepStage stageType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return SleepStageRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      stageType: stageType,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      title: title,
      notes: notes,
    );
  }

  SleepStageRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.stageType,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// The sleep stage for this record.
  ///
  /// Each record represents a single continuous period in one stage.
  final SleepStage stageType;

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
      SleepStage.awake,
      SleepStage.outOfBed,
      SleepStage.inBed,
    };
    return !awakeSleepStages.contains(stageType);
  }

  /// Creates a copy with the given fields replaced with the new values.
  SleepStageRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    SleepStage? stageType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return SleepStageRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      stageType: stageType ?? this.stageType,
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
