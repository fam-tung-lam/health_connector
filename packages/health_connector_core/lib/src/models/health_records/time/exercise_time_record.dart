part of '../health_record.dart';

/// Represents an Apple Exercise Time measurement over a time interval.
///
/// Tracks the amount of time spent exercising that contributes towards the
/// user's daily exercise goals in Apple Health.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleExerciseTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/appleexercisetime)
///
/// ## Example
///
/// ```dart
/// // Read Apple Exercise Time records
/// final request = HealthDataType.exerciseTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Exercise time: ${record.exerciseTime.inMinutes} minutes');
/// }
/// ```
///
/// ## See also
///
/// - [ExerciseTimeDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class ExerciseTimeRecord extends IntervalHealthRecord {
  /// Internal factory for creating [ExerciseTimeRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory ExerciseTimeRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required TimeDuration exerciseTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ExerciseTimeRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      exerciseTime: exerciseTime,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  ExerciseTimeRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.exerciseTime,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The duration of exercise time.
  final TimeDuration exerciseTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTimeRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          exerciseTime == other.exerciseTime;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      exerciseTime.hashCode;
}
