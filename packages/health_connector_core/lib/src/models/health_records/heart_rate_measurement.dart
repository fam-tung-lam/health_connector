import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:meta/meta.dart';

/// Represents a single heart rate measurement at a specific point in time.
///
/// This is a platform-agnostic value class used as a building block for both
/// heart rate series records (Android Health Connect) and heart rate
/// measurement records (iOS HealthKit).
///
/// Note: This class does not have an ID or metadata. Those are properties of
/// the record that contains the measurement.
@immutable
final class HeartRateMeasurement {
  /// Creates a heart rate measurement.
  const HeartRateMeasurement({
    required this.time,
    required this.beatsPerMinute,
  });

  /// The timestamp when this heart rate measurement was taken.
  final DateTime time;

  /// The heart rate value in beats per minute (BPM).
  final Number beatsPerMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateMeasurement &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          beatsPerMinute == other.beatsPerMinute;

  @override
  int get hashCode => time.hashCode ^ beatsPerMinute.hashCode;
}
