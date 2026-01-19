part of '../health_record.dart';

/// Represents a sleeping wrist temperature measurement over a time interval.
///
/// **Platform:** iOS HealthKit only.
///
/// Maps to `HKQuantityTypeIdentifier.appleSleepingWristTemperature`.
///
/// {@category Health Records}
@sinceV3_2_0
@immutable
final class SleepingWristTemperatureRecord extends IntervalHealthRecord {
  /// Internal factory for creating [SleepingWristTemperatureRecord] instances
  /// without validation.
  ///
  /// Creates a [SleepingWristTemperatureRecord] by directly mapping platform
  /// data to fields, bypassing the normal validation and business rules applied
  /// by the public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [SleepingWristTemperatureRecord] constructor, which enforces validation
  /// and business rules. This factory is restricted to the SDK developers and
  /// contributors.
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

  /// Creates a sleeping wrist temperature record.
  SleepingWristTemperatureRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.temperature,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The temperature value.
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
