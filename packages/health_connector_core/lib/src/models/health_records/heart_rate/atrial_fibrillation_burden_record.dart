part of '../health_record.dart';

/// Represents an Atrial Fibrillation Burden measurement over a time interval.
///
/// The records's value represents an estimate of the percentage of time a
/// person’s heart shows signs of AFib while wearing Apple Watch.
///
/// ## See also
///
/// - [AtrialFibrillationBurdenDataType]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class AtrialFibrillationBurdenRecord extends IntervalHealthRecord {
  /// Internal factory for creating [AtrialFibrillationBurdenRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [AtrialFibrillationBurdenRecord] constructor, which enforces
  /// validation. This factory is restricted to the SDK
  /// developers and contributors.
  @internalUse
  factory AtrialFibrillationBurdenRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Percentage percentage,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return AtrialFibrillationBurdenRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      percentage: percentage,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  AtrialFibrillationBurdenRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.percentage,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The Atrial Fibrillation Burden percentage.
  final Percentage percentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AtrialFibrillationBurdenRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          percentage == other.percentage;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      percentage.hashCode;
}
