part of '../health_record.dart';

/// Represents cross-country skiing distance over a time interval.
///
/// Specifically for nordic skiing and cross-country ski touring.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.distanceCrossCountrySkiing`
///
/// ## Example
///
/// ```dart
/// final record = CrossCountrySkiingDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 3)),
///   endTime: DateTime.now(),
///   distance: Length.kilometers(12),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CrossCountrySkiingDistanceRecord extends DistanceActivityRecord {
  /// Creates a cross-country skiing distance record.
  const CrossCountrySkiingDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  CrossCountrySkiingDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return CrossCountrySkiingDistanceRecord(
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
      other is CrossCountrySkiingDistanceRecord &&
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
