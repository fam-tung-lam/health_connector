part of '../health_record.dart';

/// Represents a contraceptive usage period.
///
/// A contraceptive record tracks the time period during which a specific
/// contraceptive method was used.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.contraceptive`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/contraceptive)
/// - **Android Health Connect**: Not supported
///
/// ## Example
///
/// ```dart
/// final contraceptive = ContraceptiveRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime(2024, 1, 1),
///   endTime: DateTime(2024, 6, 30),
///   contraceptiveType: ContraceptiveType.oral,
///   metadata: Metadata.manuallyEntered(),
/// );
/// ```
///
/// ## See also
///
/// - [ContraceptiveDataType]
/// - [ContraceptiveType]
///
/// {@category Health Records}
/// {@category Reproductive Health}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ContraceptiveRecord extends IntervalHealthRecord {
  /// Creates a contraceptive record.
  ///
  /// The record spans from [startTime] to [endTime] and specifies the
  /// [contraceptiveType] used during this period.
  ///
  /// Use [metadata] to describe the data source. Timezone offsets can be
  /// provided via [startZoneOffsetSeconds] and [endZoneOffsetSeconds].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  ContraceptiveRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.contraceptiveType,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// Internal factory for creating [ContraceptiveRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [ContraceptiveRecord] constructor, which enforces validation.
  @internalUse
  factory ContraceptiveRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required ContraceptiveType contraceptiveType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ContraceptiveRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      contraceptiveType: contraceptiveType,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  ContraceptiveRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.contraceptiveType,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The type of contraceptive method used during this period.
  ///
  /// Examples: [ContraceptiveType.oral], [ContraceptiveType.implant],
  /// [ContraceptiveType.intrauterineDevice]
  final ContraceptiveType contraceptiveType;

  /// Creates a copy with the given fields replaced with the new values.
  ContraceptiveRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    ContraceptiveType? contraceptiveType,
  }) {
    return ContraceptiveRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      contraceptiveType: contraceptiveType ?? this.contraceptiveType,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContraceptiveRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          contraceptiveType == other.contraceptiveType;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      contraceptiveType.hashCode;
}
