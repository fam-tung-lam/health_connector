part of '../health_record.dart';

/// Represents an intermenstrual bleeding occurrence at a specific point in
/// time.
///
/// Intermenstrual bleeding (also known as spotting) refers to vaginal bleeding
/// that occurs between menstrual periods. This record type simply marks that
/// intermenstrual bleeding occurred at a specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`IntermenstrualBleedingRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/IntermenstrualBleedingRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.intermenstrualBleeding`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/intermenstrualbleeding)
///
/// ## Example
///
/// ```dart
/// final record = IntermenstrualBleedingRecord(
///   id: HealthRecordId.none,
///   time: DateTime(2024, 1, 15, 10, 30),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [IntermenstrualBleedingDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@immutable
final class IntermenstrualBleedingRecord extends InstantHealthRecord {
  /// Creates an intermenstrual bleeding record.
  ///
  /// Records an occurrence of intermenstrual bleeding at a specific [time].
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  const IntermenstrualBleedingRecord({
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [IntermenstrualBleedingRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [IntermenstrualBleedingRecord] constructor, which enforces validation.
  @internalUse
  factory IntermenstrualBleedingRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    int? zoneOffsetSeconds,
  }) {
    return IntermenstrualBleedingRecord._(
      id: id,
      time: time,
      metadata: metadata,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const IntermenstrualBleedingRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  IntermenstrualBleedingRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
  }) {
    return IntermenstrualBleedingRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntermenstrualBleedingRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode;
}
