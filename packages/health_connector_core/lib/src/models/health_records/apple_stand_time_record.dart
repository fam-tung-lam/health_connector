part of 'health_record.dart';

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
/// final request = HealthDataType.appleStandTime.readInTimeRange(
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
/// - [AppleStandTimeDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class AppleStandTimeRecord extends IntervalHealthRecord {
  /// Internal factory for creating [AppleStandTimeRecord] instances without
  /// validation.
  ///
  /// Creates an [AppleStandTimeRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [AppleStandTimeRecord] constructor, which enforces validation and
  /// business rules. This factory is restricted to the SDK developers and
  /// contributors.
  @internalUse
  factory AppleStandTimeRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required TimeDuration standTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return AppleStandTimeRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      standTime: standTime,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  AppleStandTimeRecord._({
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
      other is AppleStandTimeRecord &&
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
