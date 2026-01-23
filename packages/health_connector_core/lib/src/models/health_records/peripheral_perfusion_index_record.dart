part of 'health_record.dart';

/// Represents a peripheral perfusion index record.
///
/// Peripheral perfusion index is a measurement of the blood flow to the
/// peripheral tissues, expressed as a percentage.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.peripheralPerfusionIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peripheralPerfusionIndex)
///
/// ## Example
///
/// ```dart
/// final record = PeripheralPerfusionIndexRecord(
///   time: DateTime.now(),
///   percentage: Percentage.fromWhole(95),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [PeripheralPerfusionIndexDataType]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class PeripheralPerfusionIndexRecord extends InstantHealthRecord {
  /// The peripheral perfusion index value.
  final Percentage percentage;

  /// Creates a peripheral perfusion index record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [percentage]: The peripheral perfusion index as a percentage.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  factory PeripheralPerfusionIndexRecord({
    required DateTime time,
    required Percentage percentage,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return PeripheralPerfusionIndexRecord.internal(
      time: time,
      percentage: percentage,
      metadata: metadata ?? Metadata.manualEntry(),
      id: id ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Internal factory for creating [PeripheralPerfusionIndexRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory PeripheralPerfusionIndexRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Percentage percentage,
    int? zoneOffsetSeconds,
  }) {
    return PeripheralPerfusionIndexRecord._(
      id: id,
      time: time,
      metadata: metadata,
      percentage: percentage,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  PeripheralPerfusionIndexRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.percentage,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  PeripheralPerfusionIndexRecord copyWith({
    DateTime? time,
    Percentage? percentage,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return PeripheralPerfusionIndexRecord.internal(
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
      other is PeripheralPerfusionIndexRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          metadata == other.metadata &&
          percentage == other.percentage;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode ^
      percentage.hashCode;
}
