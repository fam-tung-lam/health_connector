part of 'health_record.dart';

/// Represents a bone mass record.
///
/// This record captures the user's bone mass, which is the total weight of bone
/// in the body. It is a point-in-time measurement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BoneMassRecord`](https://developer.android.c
/// om/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)
///
/// ## Example
///
/// ```dart
/// final record = BoneMassRecord(
///   time: DateTime.now(),
///   mass: Mass.kilograms(12.5),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BoneMassDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BoneMassRecord extends InstantHealthRecord {
  /// Creates a bone mass record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [mass]: The bone mass measurement.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  const BoneMassRecord({
    required super.time,
    required super.metadata,
    required this.mass,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BoneMassRecord] instances
  /// without validation.
  ///
  /// Creates a [BoneMassRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BoneMassRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BoneMassRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass mass,
    int? zoneOffsetSeconds,
  }) {
    return BoneMassRecord._(
      id: id,
      time: time,
      metadata: metadata,
      mass: mass,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const BoneMassRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.mass,
    super.zoneOffsetSeconds,
  });

  /// The bone mass measurement.
  final Mass mass;

  /// Creates a copy with the given fields replaced with the new values.
  BoneMassRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Mass? mass,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BoneMassRecord(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      mass: mass ?? this.mass,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoneMassRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          mass == other.mass &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      mass.hashCode ^
      metadata.hashCode;
}
