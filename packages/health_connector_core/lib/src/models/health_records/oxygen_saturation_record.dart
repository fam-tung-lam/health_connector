part of 'health_record.dart';

/// A health record representing the user's oxygen saturation (SpO2).
///
/// Oxygen saturation is the fraction of oxygen-saturated hemoglobin relative
/// to total hemoglobin (unsaturated + saturated) in the blood.
///
/// This record is an [InstantHealthRecord], representing a measurement at
/// a single point in time.
@sinceV1_0_0
@immutable
final class OxygenSaturationRecord extends InstantHealthRecord {
  const OxygenSaturationRecord({
    required super.time,
    required this.percentage,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// The oxygen saturation percentage (0.0 - 1.0).
  final Percentage percentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationRecord &&
          super == other &&
          percentage == other.percentage;

  @override
  int get hashCode => Object.hash(super.hashCode, percentage);

  @override
  String toString() {
    return 'OxygenSaturationRecord { ${super.toString()}, '
        'percentage: $percentage }';
  }

  @override
  String get name => 'oxygen_saturation_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
