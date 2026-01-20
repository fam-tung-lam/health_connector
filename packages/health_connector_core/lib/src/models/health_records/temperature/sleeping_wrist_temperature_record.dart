part of '../health_record.dart';

/// Represents a sleeping wrist temperature measurement over a time interval.
///
/// [SleepingWristTemperatureRecord] tracks wrist temperature measured during
/// sleep. This is a read-only record provided by Apple Watch.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleSleepingWristTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applesleepingwristtemperature) (iOS 16+)
///
/// ## Example
///
/// ```dart
/// // This is a read-only record type provided by Apple Watch.
/// // Records are read from HealthKit, not created manually:
/// final records = await healthConnector.readRecords(
///   timeRangeFilter: TimeRangeFilter(
///     startTime: DateTime.now().subtract(Duration(days: 7)),
///     endTime: DateTime.now(),
///   ),
/// );
///
/// for (final record in records) {
///   print('Temperature: ${record.temperature.inCelsius}°C');
///   print('Time: ${record.startTime} to ${record.endTime}');
/// }
/// ```
///
/// ## See also
///
/// - [SleepingWristTemperatureDataType]
/// - [BasalBodyTemperatureRecord]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class SleepingWristTemperatureRecord extends IntervalHealthRecord {
  /// Internal factory for creating [SleepingWristTemperatureRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [SleepingWristTemperatureRecord] constructor, which enforces validation.
  @internalUse
  factory SleepingWristTemperatureRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Temperature temperature,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SleepingWristTemperatureRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      temperature: temperature,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  SleepingWristTemperatureRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.temperature,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The wrist temperature measured during sleep.
  ///
  /// This value represents the temperature deviation from the user's baseline
  /// wrist temperature during sleep, as measured by Apple Watch.
  final Temperature temperature;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepingWristTemperatureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          temperature == other.temperature;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      temperature.hashCode;
}
