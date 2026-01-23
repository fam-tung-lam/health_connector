part of '../health_record.dart';

/// Represents an Apple Stand Time measurement over a time interval.
///
/// Tracks the amount of time spent standing.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleStandTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applestandtime)
///
/// ## Example
///
/// ```dart
/// // Read Apple Stand Time records
/// final request = HealthDataType.standTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Stand time: ${record.standTime.inMinutes} minutes');
/// }
/// ```
///
/// ## See also
///
/// - [StandTimeDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class StandTimeRecord extends IntervalHealthRecord {
  /// Internal factory for creating [StandTimeRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory StandTimeRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required TimeDuration standTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return StandTimeRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      standTime: standTime,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  StandTimeRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.standTime,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The duration of stand time.
  final TimeDuration standTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandTimeRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          standTime == other.standTime;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      standTime.hashCode;
}
