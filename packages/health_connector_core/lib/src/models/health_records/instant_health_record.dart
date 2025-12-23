part of 'health_record.dart';

/// A health record representing a measurement at a single point in time.
///
/// ## Time Representation
///
/// ### Android Health Connect
/// - Single timestamp stored as "time"
/// - Timezone offset supported and preserved
/// - Instant records map to `InstantRecord` subclasses
///
/// ### iOS HealthKit
/// - Maps to HKQuantitySample or HKCategorySample
/// - Start and end dates are the same (point-in-time)
/// ```
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class InstantHealthRecord extends HealthRecord {
  /// Creates an instant health record at the specified [time].
  ///
  /// The [zoneOffsetSeconds] is optional and represents the timezone offset
  /// in seconds from UTC at the time of measurement.
  ///
  /// Example:
  /// ```dart
  /// final record = WeightRecord(
  ///   time: DateTime.now(),
  ///   weight: Mass.kilograms(72.0),
  ///   metadata: Metadata.manualEntry(),
  /// );
  /// ```
  const InstantHealthRecord({
    required this.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    this.zoneOffsetSeconds,
  });

  /// The time when this measurement was taken.
  ///
  /// This represents the exact moment the health data was recorded or measured.
  final DateTime time;

  /// The timezone offset in seconds at the time of measurement.
  ///
  /// This represents the offset from UTC at [time]:
  /// - Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
  /// - Negative for timezones behind UTC (e.g., -28800 for UTC-8)
  /// - Null if timezone information is not available
  ///
  /// **Platform differences:**
  /// - **Android Health Connect:** Timezone offset fully supported
  /// - **iOS HealthKit:** Timezone information less explicit, typically uses
  ///   device timezone
  final int? zoneOffsetSeconds;
}
