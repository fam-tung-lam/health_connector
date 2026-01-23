part of 'health_record.dart';

/// Captures the elevation gained by the user.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ElevationGainedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ElevationGainedRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.flightsClimbed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed) (Approximation)
///
/// ## Example
///
/// ```dart
/// final record = ElevationGainedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   elevation: Length.meters(50),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [ElevationGainedDataType]
///
/// {@category Health Records}
///
/// **Validation**:
/// - [elevation] must be between -1000000 and 1000000 meters.
@sinceV3_1_0
@supportedOnHealthConnect
@immutable
final class ElevationGainedRecord extends IntervalHealthRecord {
  /// Minimum valid elevation (-1,000,000 m).
  static const Length minElevation = Length.meters(-1000000.0);

  /// Maximum valid elevation (1,000,000 m).
  static const Length maxElevation = Length.meters(1000000.0);

  /// Creates an [ElevationGainedRecord] instance.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [elevation]: The elevation gained in meters.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [elevation] is outside the valid range of
  ///   [minElevation]-[maxElevation].
  ElevationGainedRecord({
    required this.elevation,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: elevation >= minElevation && elevation <= maxElevation,
      value: elevation,
      name: 'elevation',
      message:
          'Elevation must be between '
          '${minElevation.inMeters.toStringAsFixed(0)} and '
          '${maxElevation.inMeters.toStringAsFixed(0)} meters. '
          'Got ${elevation.inMeters.toStringAsFixed(1)} meters.',
    );
  }

  /// Internal factory for creating [ElevationGainedRecord] instances
  /// without validation.
  @internalUse
  factory ElevationGainedRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length elevation,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ElevationGainedRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      elevation: elevation,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  ElevationGainedRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.elevation,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The elevation gained measurement value.
  final Length elevation;

  /// Creates a copy with the given fields replaced with the new values.
  ElevationGainedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? elevation,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ElevationGainedRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      elevation: elevation ?? this.elevation,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ElevationGainedRecord &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            metadata == other.metadata &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
            endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
            elevation.inMeters == other.elevation.inMeters;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      elevation.hashCode;

  @override
  String toString() {
    return 'ElevationGainedRecord{elevation: $elevation, ${super.toString()}}';
  }
}
