part of '../health_record.dart';

/// Represents six-minute walk test distance.
///
/// A standardized medical assessment measuring the distance walked in
/// six minutes, commonly used to evaluate functional exercise capacity.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [DistanceRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.sixMinuteWalkTestDistance`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/sixminutewalktestdistance)
///
/// ## Example
///
/// ```dart
/// final record = SixMinuteWalkTestDistanceRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 6)),
///   endTime: DateTime.now(),
///   distance: Length.meters(450),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class SixMinuteWalkTestDistanceRecord extends DistanceActivityRecord {
  /// Creates a six-minute walk test distance record.
  SixMinuteWalkTestDistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [SixMinuteWalkTestDistanceRecord] instances
  /// without validation.
  ///
  /// Creates a [SixMinuteWalkTestDistanceRecord] by directly mapping platform
  /// data to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [SixMinuteWalkTestDistanceRecord] constructor, which enforces validation
  /// and business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory SixMinuteWalkTestDistanceRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length distance,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SixMinuteWalkTestDistanceRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      distance: distance,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  SixMinuteWalkTestDistanceRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.distance,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  SixMinuteWalkTestDistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SixMinuteWalkTestDistanceRecord(
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
      other is SixMinuteWalkTestDistanceRecord &&
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
