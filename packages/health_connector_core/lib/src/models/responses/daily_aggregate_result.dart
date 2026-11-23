import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:meta/meta.dart';

/// An aggregated measurement for one complete local calendar day.
///
/// Boundaries identify the calendar date in the device time zone. On Android,
/// Health Connect assigns records using their recorded local times and offsets,
/// so these boundaries do not reproject travel history into that time zone.
///
/// A missing readable measurement is represented by a null [value], while a
/// measured zero is preserved. HealthKit does not reveal read authorization,
/// so a null value cannot distinguish missing data from denied read access.
///
/// {@category Core API}
@sinceV3_15_0
@immutable
final class DailyAggregateResult<U extends MeasurementUnit> {
  /// Creates a daily result with inclusive start and exclusive end boundaries.
  @sinceV3_15_0
  const DailyAggregateResult({
    required this.startTime,
    required this.endTime,
    required this.value,
  });

  /// Inclusive day boundary in the device's time zone at query start.
  @sinceV3_15_0
  final DateTime startTime;

  /// Exclusive next-day boundary; a day may contain 23, 24, or 25 hours.
  @sinceV3_15_0
  final DateTime endTime;

  /// The aggregated measurement, or null when no measurement is readable.
  @sinceV3_15_0
  final U? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAggregateResult<U> &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          value == other.value;

  @override
  int get hashCode => Object.hash(startTime, endTime, value);

  @override
  String toString() => 'DailyAggregateResult(hasValue=${value != null})';
}
