part of '../health_record.dart';

/// Represents cervical mucus observation at a specific point in time.
///
/// ## Platform Mapping
/// - **Android**: [`CervicalMucusRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)
/// - **iOS**: [`HKCategoryTypeIdentifier.cervicalMucusQuality`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalMucusQuality)
///
/// {@category Health Data Types}
@sinceV2_1_0
@immutable
final class CervicalMucusRecord extends InstantHealthRecord {
  /// Creates a cervical mucus record.
  const CervicalMucusRecord({
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.appearance = CervicalMucusAppearanceType.unknown,
    this.sensation = CervicalMucusSensationType.unknown,
  });

  /// Cervical mucus appearance (optional).
  final CervicalMucusAppearanceType appearance;

  /// Cervical mucus sensation/amount (optional).
  final CervicalMucusSensationType sensation;

  /// Creates a copy of this record with the given fields replaced.
  CervicalMucusRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    CervicalMucusAppearanceType? appearance,
    CervicalMucusSensationType? sensation,
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

/// Cervical mucus sensation types.
///
/// ## Platform Mapping
///
/// - **Android**: Full 1:1 mapping via `CervicalMucusRecord.SENSATION_*`
/// - **iOS**: No native support - uses custom metadata
///
/// ## iOS HealthKit Limitation
///
/// HealthKit's `HKCategoryTypeIdentifier.cervicalMucusQuality` only tracks
/// appearance, not sensation. All sensation values are stored using the
/// custom metadata key and handled by the SDK.
@sinceV2_1_0
enum CervicalMucusSensationType {
  /// Unknown sensation.
  unknown,

  /// Light sensation.
  light,

  /// Medium sensation.
  medium,

  /// Heavy sensation.
  heavy,
}

/// Cervical mucus appearance types.
///
/// ## Platform Mapping
/// - **Android Health Connect**: Full 1:1 mapping via
///   `CervicalMucusRecord.APPEARANCE_*`
/// - **iOS HealthKit**:
///   - Natively supports: `dry`, `sticky`, `creamy`, `watery`, `eggWhite`
///   - `unusual` and `unknown` are stored in custom metadata key and handled by
///     the SKK
///
/// {@category Health Records}
@sinceV2_1_0
enum CervicalMucusAppearanceType {
  /// Unknown appearance.
  unknown,

  /// Dry appearance.
  dry,

  /// Sticky appearance.
  sticky,

  /// Creamy appearance.
  creamy,

  /// Watery appearance.
  watery,

  /// Egg white appearance.
  eggWhite,

  /// Unusual appearance.
  unusual,
}
