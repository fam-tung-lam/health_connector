part of '../health_record.dart';

/// Represents a single cycling pedaling cadence measurement.
///
/// Each cycling pedaling cadence measurement record represents one RPM
/// measurement at a specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
///   (Use [CyclingPedalingCadenceSeriesRecord])
/// - **iOS HealthKit**:
///   [`HKQuantityTypeIdentifier.cyclingCadence`](https://developer.apple.com/do
/// cumentation/healthkit/hkquantitytypeidentifier/cyclingcadence)
///
/// ## Example
///
/// ```dart
/// final record = CyclingPedalingCadenceRecord(
///   id: HealthRecordId('ABC-123'),
///   time: DateTime.now(),
///   cadence: Frequency.perMinute(85),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [CyclingPedalingCadenceDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class CyclingPedalingCadenceRecord extends InstantHealthRecord {
  /// Creates a cycling pedaling cadence measurement record.
  /// Creates a cycling pedaling cadence measurement record.
  const CyclingPedalingCadenceRecord({
    required super.id,
    required this.cadence,
    required super.time,
    required super.metadata,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [CyclingPedalingCadenceRecord] instances
  /// without validation.
  ///
  /// Creates a [CyclingPedalingCadenceRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [CyclingPedalingCadenceRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory CyclingPedalingCadenceRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Frequency cadence,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceRecord._(
      id: id,
      time: time,
      metadata: metadata,
      cadence: cadence,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const CyclingPedalingCadenceRecord._({
    required super.id,
    required super.metadata,
    required super.time,
    required this.cadence,
    super.zoneOffsetSeconds,
  });

  /// The cycling cadence value in revolutions per minute (RPM).
  final Frequency cadence;

  /// The cycling cadence value in revolutions per minute (RPM).
  /// Creates a copy with the given fields replaced with the new values.
  CyclingPedalingCadenceRecord copyWith({
    HealthRecordId? id,
    Frequency? cadence,
    DateTime? time,
    Metadata? metadata,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceRecord(
      id: id ?? this.id,
      cadence: cadence ?? this.cadence,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          cadence == other.cadence;

  @override
  int get hashCode => id.hashCode ^ metadata.hashCode ^ cadence.hashCode;
}
