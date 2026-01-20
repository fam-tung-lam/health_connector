part of '../health_record.dart';

/// Represents a single cycling pedaling cadence measurement.
///
/// Each cycling pedaling cadence measurement record represents one RPM
/// measurement at a specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported. Use
///   [CyclingPedalingCadenceSeriesRecord] instead.
/// - **iOS HealthKit**:  [`HKQuantityTypeIdentifier.cyclingCadence`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingcadence)
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
@supportedOnAppleHealthIOS17Plus
@immutable
final class CyclingPedalingCadenceRecord extends InstantHealthRecord {
  /// Minimum valid cycling cadence (0.0 RPM).
  ///
  /// Not pedaling (coasting).
  static final Frequency minCadence = Frequency.perMinute(0.0);

  /// Maximum valid cycling cadence (200.0 RPM).
  ///
  /// Typical cadence 60-100 RPM; elite cyclists ~120 RPM; 200 RPM allows for
  /// brief sprint peaks.
  static final Frequency maxCadence = Frequency.perMinute(200.0);

  /// Creates a cycling pedaling cadence measurement record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [cadence] is outside the valid range of
  /// - [ArgumentError] if [cadence] is outside the valid range of
  ///   [minCadence]-[maxCadence] RPM.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minCadence] RPM)**: Not pedaling (coasting).
  /// - **Maximum ([maxCadence] RPM)**: Typical cadence 60-100 RPM; elite
  ///   cyclists ~120 RPM; 200 RPM allows for brief sprint peaks.
  CyclingPedalingCadenceRecord({
    required super.id,
    required this.cadence,
    required super.time,
    required super.metadata,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: cadence >= minCadence && cadence <= maxCadence,
      value: cadence,
      name: 'cadence',
      message:
          'Cycling cadence must be between '
          '${minCadence.inPerMinute.toStringAsFixed(0)}-'
          '${maxCadence.inPerMinute.toStringAsFixed(0)} RPM. '
          'Got ${cadence.inPerMinute.toStringAsFixed(0)} RPM.',
    );
  }

  /// Internal factory for creating [CyclingPedalingCadenceRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [CyclingPedalingCadenceRecord] constructor, which enforces validation.
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
