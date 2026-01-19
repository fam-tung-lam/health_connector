part of '../health_record.dart';

/// Represents an Apple Move Time measurement over a time interval.
///
/// Tracks the amount of time spent active (moving) that contributes towards the
/// user's daily move goals in Apple Health.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleMoveTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applemovetime)
///
/// ## Example
///
/// ```dart
/// // Read Apple Move Time records
/// final request = HealthDataType.moveTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Move time: ${record.moveTime.inMinutes} minutes');
/// }
/// ```
///
/// ## See also
///
/// - [MoveTimeDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class MoveTimeRecord extends IntervalHealthRecord {
  /// Internal factory for creating [MoveTimeRecord] instances without
  /// validation.
  ///
  /// Creates an [MoveTimeRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [MoveTimeRecord] constructor, which enforces validation and
  /// business rules. This factory is restricted to the SDK developers and
  /// contributors.
  @internalUse
  factory MoveTimeRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required TimeDuration moveTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return MoveTimeRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      moveTime: moveTime,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  MoveTimeRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.moveTime,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The duration of move time.
  final TimeDuration moveTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveTimeRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          moveTime == other.moveTime;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      moveTime.hashCode;
}
