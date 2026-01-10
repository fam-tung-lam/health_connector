import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:meta/meta.dart';

/// Represents a single cycling pedaling cadence measurement at a specific
/// point in time.
///
/// **Note**: This class does not have an ID or metadata. Those are
/// properties of the record that contains the measurement.
///
/// {@category Health Records}
@immutable
final class CyclingPedalingCadenceMeasurement {
  /// Creates a cycling pedaling cadence measurement.
  const CyclingPedalingCadenceMeasurement({
    required this.time,
    required this.cadence,
  });

  /// The timestamp when this cadence measurement was taken, stored as a
  /// UTC instant.
  ///
  /// Timezone offset information is provided by the parent record.
  final DateTime time;

  /// The cycling cadence value in revolutions per minute (RPM).
  final Number cadence;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceMeasurement &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          cadence == other.cadence;

  @override
  int get hashCode => time.hashCode ^ cadence.hashCode;
}
