part of 'health_record.dart';

/// Represents an oxygen saturation (SpO₂) measurement at a specific point in
/// time.
///
/// [OxygenSaturationRecord] captures the fraction of oxygen-saturated
/// hemoglobin
/// relative to total hemoglobin in the blood. This measurement is expressed as
/// a
/// percentage (0.0 - 1.0) and is a vital sign indicating respiratory function.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`OxygenSaturationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.oxygenSaturation`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)
///
/// ## Example
///
/// ```dart
/// final record = OxygenSaturationRecord(
///   time: DateTime.now(),
///   saturation: Percentage.fromWhole(98), // 98% SpO₂
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [OxygenSaturationDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class OxygenSaturationRecord extends InstantHealthRecord {
  /// Minimum valid oxygen saturation (0%).
  ///
  /// Theoretical lower limit; values < 65% rarely survivable but allowed for
  /// measurement artifacts.
  static const Percentage minSaturation = Percentage.zero;

  /// Maximum valid oxygen saturation (100%).
  ///
  /// Physical maximum for oxygen saturation.
  static const Percentage maxSaturation = Percentage.full;

  /// Creates an oxygen saturation record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the oxygen saturation was measured.
  /// - [saturation]: The oxygen saturation percentage (as decimal 0.0 - 1.0).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [saturation] is outside the valid range of
  ///   [minSaturation]-[maxSaturation]%.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSaturation]%)**: Theoretical lower limit;
  ///   values < 65% rarely survivable but allowed for measurement artifacts.
  /// - **Maximum ([maxSaturation]%)**: Physical maximum for oxygen
  ///   saturation.
  OxygenSaturationRecord({
    required super.time,
    required this.saturation,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: saturation >= minSaturation && saturation <= maxSaturation,
      value: saturation,
      name: 'saturation',
      message:
          'Oxygen saturation must be between '
          '${minSaturation.asWhole.toStringAsFixed(0)}-'
          '${maxSaturation.asWhole.toStringAsFixed(0)}%. '
          'Got ${saturation.asWhole.toStringAsFixed(1)}%.',
    );
  }

  /// Internal factory for creating [OxygenSaturationRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [OxygenSaturationRecord] constructor, which enforces validation.
  @internalUse
  factory OxygenSaturationRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Percentage saturation,
    int? zoneOffsetSeconds,
  }) {
    return OxygenSaturationRecord._(
      id: id,
      time: time,
      metadata: metadata,
      saturation: saturation,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const OxygenSaturationRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.saturation,
    super.zoneOffsetSeconds,
  });

  /// The oxygen saturation percentage (0.0 - 1.0).
  final Percentage saturation;

  /// Creates a copy with the given fields replaced with the new values.
  OxygenSaturationRecord copyWith({
    DateTime? time,
    Percentage? saturation,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return OxygenSaturationRecord(
      time: time ?? this.time,
      saturation: saturation ?? this.saturation,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          metadata == other.metadata &&
          saturation == other.saturation;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode ^
      saturation.hashCode;
}
