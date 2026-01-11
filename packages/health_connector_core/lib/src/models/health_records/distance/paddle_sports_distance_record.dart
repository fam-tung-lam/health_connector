part of '../health_record.dart';

/// Represents paddle sports distance over a time interval.
///
/// Includes kayaking, canoeing, stand-up paddleboarding, and other
/// paddle-based water sports.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [DistanceRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.distancePaddleSports`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancepaddlesports)
///
/// ## Example
///
/// ```dart
/// final record = PaddleSportsDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 2)),
///   endTime: DateTime.now(),
///   distance: Length.kilometers(8),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class PaddleSportsDistanceRecord extends DistanceActivityRecord {
  /// Creates a paddle sports distance record.
  PaddleSportsDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [PaddleSportsDistanceRecord] instances
  /// without validation.
  ///
  /// Creates a [PaddleSportsDistanceRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [PaddleSportsDistanceRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory PaddleSportsDistanceRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length distance,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PaddleSportsDistanceRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      distance: distance,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  PaddleSportsDistanceRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  PaddleSportsDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PaddleSportsDistanceRecord(
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
      other is PaddleSportsDistanceRecord &&
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
