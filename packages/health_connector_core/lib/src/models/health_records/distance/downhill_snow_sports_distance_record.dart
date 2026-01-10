part of '../health_record.dart';

/// Represents downhill snow sports distance over a time interval.
///
/// Includes skiing, snowboarding, and other downhill winter sports.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [DistanceRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.distanceDownhillSnowSports`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancedownhillsnowsports)
///
/// ## Example
///
/// ```dart
/// final record = DownhillSnowSportsDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 4)),
///   endTime: DateTime.now(),
///   distance: Length.kilometers(15),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class DownhillSnowSportsDistanceRecord extends DistanceActivityRecord {
  /// Creates a downhill snow sports distance record.
  DownhillSnowSportsDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  DownhillSnowSportsDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return DownhillSnowSportsDistanceRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distance: distance ?? this.distance,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownhillSnowSportsDistanceRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          distance == other.distance &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      distance.hashCode ^
      metadata.hashCode;
}
