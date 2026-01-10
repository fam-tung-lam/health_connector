part of '../health_record.dart';

/// Represents wheelchair distance over a time interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [DistanceRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.distanceWheelchair`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair)
///
/// ## Example
///
/// ```dart
/// final record = WheelchairDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   distance: Length.kilometers(3),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class WheelchairDistanceRecord extends DistanceActivityRecord {
  /// Creates a wheelchair distance record.
  WheelchairDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  WheelchairDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WheelchairDistanceRecord(
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
      other is WheelchairDistanceRecord &&
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
