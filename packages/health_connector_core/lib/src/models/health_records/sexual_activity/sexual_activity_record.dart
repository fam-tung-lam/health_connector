part of '../health_record.dart';

/// Represents a sexual activity occurrence.
///
/// A sexual activity record tracks an occurrence of sexual activity at a
/// specific point in time with optional information about whether protection
/// was used.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SexualActivityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SexualActivityRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.sexualActivity`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sexualactivity)
///
/// ## Example
///
/// ```dart
/// final activity = SexualActivityRecord(
///   id: HealthRecordId.none,
///   time: DateTime(2024, 1, 15, 22, 0),
///   protectionUsed: SexualActivityProtectionUsedType.protected,
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [SexualActivityDataType]
/// - [SexualActivityProtectionUsed]
///
/// {@category Health Records}
@sinceV2_1_0
@immutable
final class SexualActivityRecord extends InstantHealthRecord {
  /// Creates a sexual activity record.
  ///
  /// Records an occurrence of sexual activity at a specific [time].
  /// Optional [protectionUsed] information can be provided.
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  SexualActivityRecord({
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.protectionUsed = SexualActivityProtectionUsed.unknown,
  });

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules.
  @internalUse
  factory SexualActivityRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    int? zoneOffsetSeconds,
    SexualActivityProtectionUsed protectionUsed =
        SexualActivityProtectionUsed.unknown,
  }) {
    return SexualActivityRecord._(
      id: id,
      time: time,
      metadata: metadata,
      zoneOffsetSeconds: zoneOffsetSeconds,
      protectionUsed: protectionUsed,
    );
  }

  SexualActivityRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    super.zoneOffsetSeconds,
    this.protectionUsed = SexualActivityProtectionUsed.unknown,
  });

  /// Optional information about whether protection was used.
  ///
  /// - `protected`: Protection was used
  /// - `unprotected`: Protection was not used
  /// - `unknown`: Unknown or not specified
  final SexualActivityProtectionUsed protectionUsed;

  /// Creates a copy with the given fields replaced with the new values.
  SexualActivityRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    SexualActivityProtectionUsed? protectionUsed,
  }) {
    return SexualActivityRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      protectionUsed: protectionUsed ?? this.protectionUsed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexualActivityRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          protectionUsed == other.protectionUsed;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      protectionUsed.hashCode;
}
