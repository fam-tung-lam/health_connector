part of 'health_record.dart';

/// Represents a blood alcohol content record.
///
/// [BloodAlcoholContentRecord] captures the user's blood alcohol content (BAC)
/// as a percentage.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodAlcoholContent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodAlcoholContent)
/// - **Android Health Connect**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = BloodAlcoholContentRecord(
///   time: DateTime.now(),
///   percentage: Percentage.fromWhole(0.08), // 0.08% BAC
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BloodAlcoholContentDataType]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class BloodAlcoholContentRecord extends InstantHealthRecord {
  /// Minimum valid BAC percentage (0.0%).
  static const Percentage minPercentage = Percentage.zero;

  /// Maximum valid BAC percentage (1.0%).
  ///
  /// This is 100% alcohol in blood, which is lethal but theoretically the max.
  static const Percentage maxPercentage = Percentage.full;

  /// Creates a blood alcohol content record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when measurements were taken.
  /// - [zoneOffsetSeconds]: Optional timezone offset.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [percentage]: The blood alcohol content as a percentage (0.0% - 100.0%).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [percentage] is outside the valid range of
  ///   [minPercentage]-[maxPercentage]%.
  BloodAlcoholContentRecord({
    required super.time,
    required super.metadata,
    required this.percentage,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: percentage >= minPercentage && percentage <= maxPercentage,
      value: percentage,
      name: 'percentage',
      message:
          'Percentage must be between ${minPercentage.asWhole}-'
          '${maxPercentage.asWhole}. '
          'Got ${percentage.asWhole}.',
    );
  }

  /// Internal factory for creating [BloodAlcoholContentRecord] instances
  /// without validation.
  @internalUse
  factory BloodAlcoholContentRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Percentage percentage,
    int? zoneOffsetSeconds,
  }) {
    return BloodAlcoholContentRecord._(
      id: id,
      time: time,
      metadata: metadata,
      percentage: percentage,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const BloodAlcoholContentRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.percentage,
    super.zoneOffsetSeconds,
  });

  /// The blood alcohol content as a percentage.
  final Percentage percentage;

  /// Creates a copy with the given fields replaced with the new values.
  BloodAlcoholContentRecord copyWith({
    DateTime? time,
    Percentage? percentage,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BloodAlcoholContentRecord(
      time: time ?? this.time,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodAlcoholContentRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          percentage == other.percentage &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      percentage.hashCode ^
      metadata.hashCode;
}
