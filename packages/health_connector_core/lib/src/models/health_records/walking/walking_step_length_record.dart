part of '../health_record.dart';

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
/// // Write a Walking Step Length record
/// final record = WalkingStepLengthRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 5)),
///   endTime: DateTime.now(),
///   length: Length.meters(0.75),
///   devicePlacementSide: DevicePlacementSide.left,
///   metadata: Metadata.manualEntry(),
/// );
/// await connector.writeRecords([record]);
///
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
  /// Minimum valid walking step length (0.20 meters / 20 cm).
  ///
  /// Accommodates medical conditions, elderly individuals with mobility issues,
  /// children, and pathological gaits.
  static const Length minStepLength = Length.centimeters(20.0);

  /// Maximum valid walking step length (2.0 meters).
  ///
  /// Accommodates tall individuals, athletes, and fast walking. Normal maximum
  /// is around 1.1 meters; 2.0 meters provides margin for edge cases.
  static const Length maxStepLength = Length.meters(2.0);

  /// Creates a walking step length record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [length]: The walking step length measurement.
  /// - [devicePlacementSide]: The placement side of the device used for
  ///   measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [length] is outside the valid range of
  ///   [minStepLength]-[maxStepLength].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minStepLength])**: Accommodates medical conditions, elderly
  ///   individuals with mobility issues, children, and pathological gaits.
  /// - **Maximum ([maxStepLength])**: Accommodates tall individuals, athletes,
  ///   and fast walking. Normal maximum is around 1.1 meters; 2.0 meters
  ///   provides margin for edge cases.
  WalkingStepLengthRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.length,
    required this.devicePlacementSide,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: length >= minStepLength && length <= maxStepLength,
      value: length,
      name: 'length',
      message:
          'Walking step length must be between '
          '${minStepLength.inCentimeters.toStringAsFixed(0)} cm-'
          '${maxStepLength.inMeters.toStringAsFixed(1)} m. '
          'Got ${length.inCentimeters.toStringAsFixed(1)} cm.',
    );
  }

  /// Internal factory for creating [WalkingStepLengthRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WalkingStepLengthRecord] constructor, which enforces validation.
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
