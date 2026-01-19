part of 'health_record.dart';

/// Represents a Walking Step Length measurement over a time interval.
///
/// Tracks the distance between the point of initial contact of one foot
/// and the point of initial contact of the opposite foot.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.walkingStepLength`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingsteplength)
///
/// ## Example
///
/// ```dart
/// // Read Walking Step Length records
/// final request = HealthDataType.walkingStepLength.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Step length: ${record.length.inMeters} meters');
///   print('Device side: ${record.devicePlacementSide}');
/// }
/// ```
///
/// ## See also
///
/// - [WalkingStepLengthDataType]
/// - [DevicePlacementSide]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class WalkingStepLengthRecord extends IntervalHealthRecord {
  /// Internal factory for creating [WalkingStepLengthRecord] instances
  /// without validation.
  ///
  /// Creates a [WalkingStepLengthRecord] by directly mapping platform data
  /// to fields, bypassing the normal validation and business rules applied
  /// by the public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WalkingStepLengthRecord] constructor, which enforces validation and
  /// business rules. This factory is restricted to the SDK developers and
  /// contributors.
  @internalUse
  factory WalkingStepLengthRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length length,
    required DevicePlacementSide devicePlacementSide,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingStepLengthRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      length: length,
      devicePlacementSide: devicePlacementSide,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  WalkingStepLengthRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.length,
    required this.devicePlacementSide,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The walking step length.
  final Length length;

  /// The placement side of the device used to measure walking step length.
  final DevicePlacementSide devicePlacementSide;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingStepLengthRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          length == other.length &&
          devicePlacementSide == other.devicePlacementSide;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      length.hashCode ^
      devicePlacementSide.hashCode;
}
