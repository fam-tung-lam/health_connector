part of 'health_record.dart';

/// Represents a body water mass record.
///
/// This record captures the user's body water mass, which is the total weight
/// of water in the body. It is a point-in-time measurement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyWaterMassRecord`](https://developer.andr
/// oid.com/reference/kotlin/androidx/health/connect/client/records/BodyWaterMas
/// sRecord)
/// - **iOS HealthKit**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = BodyWaterMassRecord(
///   time: DateTime.now(),
///   mass: Mass.kilograms(45.0),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BodyWaterMassDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BodyWaterMassRecord extends InstantHealthRecord {
  /// Creates a body water mass record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [mass]: The body water mass measurement.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  const BodyWaterMassRecord({
    required super.time,
    required super.metadata,
    required this.mass,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BodyWaterMassRecord] instances
  /// without validation.
  ///
  /// Creates a [BodyWaterMassRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BodyWaterMassRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BodyWaterMassRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass mass,
    int? zoneOffsetSeconds,
  }) {
    return BodyWaterMassRecord._(
      id: id,
      time: time,
      metadata: metadata,
      mass: mass,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const BodyWaterMassRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.mass,
    super.zoneOffsetSeconds,
  });

  /// The body water mass measurement.
  final Mass mass;

  /// Creates a copy with the given fields replaced with the new values.
  BodyWaterMassRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Mass? mass,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyWaterMassRecord(
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
      other is BodyWaterMassRecord &&
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
