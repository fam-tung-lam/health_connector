part of '../../health_record.dart';

/// Represents cervical mucus observation at a specific point in time.
///
/// ## Platform Mapping
/// - **Android Health Connect**: [`CervicalMucusRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.cervicalMucusQuality`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalMucusQuality)
///
/// {@category Health Records}
@sinceV2_1_0
@immutable
final class CervicalMucusRecord extends InstantHealthRecord {
  /// Creates a cervical mucus record.
  CervicalMucusRecord({
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.appearance = CervicalMucusAppearance.unknown,
    this.sensation = CervicalMucusSensation.unknown,
  });

  /// Internal factory for creating [CervicalMucusRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory CervicalMucusRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    int? zoneOffsetSeconds,
    CervicalMucusAppearance appearance = CervicalMucusAppearance.unknown,
    CervicalMucusSensation sensation = CervicalMucusSensation.unknown,
  }) {
    return CervicalMucusRecord._(
      id: id,
      time: time,
      metadata: metadata,
      zoneOffsetSeconds: zoneOffsetSeconds,
      appearance: appearance,
      sensation: sensation,
    );
  }

  CervicalMucusRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    super.zoneOffsetSeconds,
    this.appearance = CervicalMucusAppearance.unknown,
    this.sensation = CervicalMucusSensation.unknown,
  });

  /// Cervical mucus appearance (optional).
  final CervicalMucusAppearance appearance;

  /// Cervical mucus sensation/amount (optional).
  final CervicalMucusSensation sensation;

  /// Creates a copy of this record with the given fields replaced.
  CervicalMucusRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    CervicalMucusAppearance? appearance,
    CervicalMucusSensation? sensation,
  }) {
    return CervicalMucusRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      appearance: appearance ?? this.appearance,
      sensation: sensation ?? this.sensation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CervicalMucusRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          appearance == other.appearance &&
          sensation == other.sensation;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      appearance.hashCode ^
      sensation.hashCode;
}
