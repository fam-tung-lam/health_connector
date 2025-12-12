part of 'measurement_unit.dart';

/// A unit of measurement for respiratory rate.
@sinceV1_0_0
@immutable
final class RespiratoryRate extends MeasurementUnit {
  const RespiratoryRate({
    required this.breathsPerMinute,
  });

  /// The respiratory rate in breaths per minute.
  final double breathsPerMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRate &&
          runtimeType == other.runtimeType &&
          breathsPerMinute == other.breathsPerMinute;

  @override
  int get hashCode => breathsPerMinute.hashCode;

  @override
  String get name => 'RespiratoryRate';

  @override
  String toString() => 'RespiratoryRate(breathsPerMinute: $breathsPerMinute)';
}
