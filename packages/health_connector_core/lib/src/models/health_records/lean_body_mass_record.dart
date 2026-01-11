part of 'health_record.dart';

/// Represents a lean body mass measurement at a specific point in time.
///
/// [LeanBodyMassRecord] captures the user's lean body mass as an instant
/// measurement. Lean body mass is the total weight of the body minus the
/// weight of body fat. This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`LeanBodyMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.leanBodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass)
///
/// ## Example
///
/// ```dart
/// final record = LeanBodyMassRecord(
///   time: DateTime.now(),
///   mass: Mass.kilograms(60.0),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [LeanBodyMassDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class LeanBodyMassRecord extends InstantHealthRecord {
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the lean body mass was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [mass]: The lean body mass measurement.
  const LeanBodyMassRecord({
    required super.time,
    required super.metadata,
    required this.mass,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [LeanBodyMassRecord] instances
  /// without validation.
  ///
  /// Creates a [LeanBodyMassRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [LeanBodyMassRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory LeanBodyMassRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass mass,
    int? zoneOffsetSeconds,
  }) {
    return LeanBodyMassRecord._(
      id: id,
      time: time,
      metadata: metadata,
      mass: mass,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const LeanBodyMassRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.mass,
    super.zoneOffsetSeconds,
  });

  /// The lean body mass measurement.
  ///
  /// This uses the [Mass] unit class which supports multiple units
  /// (kilograms, grams, pounds, ounces).
  final Mass mass;

  /// Creates a copy with the given fields replaced with the new values.
  LeanBodyMassRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Mass? mass,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return LeanBodyMassRecord(
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
      other is LeanBodyMassRecord &&
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
