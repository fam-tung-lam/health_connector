part of '../health_record.dart';

/// Walking Steadiness Event record.
///
/// Records an incident where the user showed a reduced score for
/// their gait’s steadiness.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.appleWalkingSteadinessEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/applewalkingsteadinessevent)
///
/// ## See also
///
/// - [WalkingSteadinessEventDataType]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@immutable
class WalkingSteadinessEventRecord extends IntervalHealthRecord {
  /// The type of walking steadiness event.
  final WalkingSteadinessType type;

  /// Internal factory for creating [WalkingSteadinessEventRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory WalkingSteadinessEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required WalkingSteadinessType type,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingSteadinessEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      type: type,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a [WalkingSteadinessEventRecord].
  WalkingSteadinessEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.type,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSteadinessEventRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          type == other.type &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      type.hashCode;
}

/// The type of walking steadiness event.
@sinceV3_4_0
@supportedOnAppleHealth
enum WalkingSteadinessType {
  /// The user's walking steadiness score is low.
  initialLow,

  /// The user's walking steadiness score remains low.
  repeatLow,

  /// The user's walking steadiness score is very low.
  initialVeryLow,

  /// The user's walking steadiness score remains very low.
  repeatVeryLow,
}
