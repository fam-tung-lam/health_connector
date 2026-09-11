part of '../health_record.dart';

/// An hourly Apple Stand or Roll status recorded by Apple Watch.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**:
///   [`HKCategoryTypeIdentifier.appleStandHour`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/applestandhour)
///
/// ## See also
///
/// - [AppleStandHourDataType]
/// - [AppleStandHourStatus]
///
@sinceV3_11_0
@readOnly
@immutable
final class AppleStandHourRecord extends IntervalHealthRecord {
  /// Internal factory for creating [AppleStandHourRecord] instances without
  /// validation.
  ///
  /// **Warning**: Not for public use.
  @internalUse
  factory AppleStandHourRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required AppleStandHourStatus status,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return AppleStandHourRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      status: status,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  AppleStandHourRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.status,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Whether the user completed the Stand or Roll goal during this hour.
  final AppleStandHourStatus status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppleStandHourRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata &&
          status == other.status;

  @override
  int get hashCode => Object.hash(
    id,
    startTime,
    endTime,
    startZoneOffsetSeconds,
    endZoneOffsetSeconds,
    metadata,
    status,
  );
}
