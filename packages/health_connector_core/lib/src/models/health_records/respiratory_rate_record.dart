part of 'health_record.dart';

/// A health record representing the user's respiratory rate.
///
/// Respiratory rate is the number of breaths a person takes per minute.
///
/// This record is an [InstantHealthRecord], representing a measurement at
/// a single point in time.
@sinceV1_0_0
@immutable
final class RespiratoryRateRecord extends InstantHealthRecord {
  const RespiratoryRateRecord({
    required super.time,
    required this.rate,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// The respiratory rate measurement.
  final RespiratoryRate rate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord && super == other && rate == other.rate;

  @override
  int get hashCode => Object.hash(super.hashCode, rate);

  @override
  String toString() {
    return 'RespiratoryRateRecord { ${super.toString()}, '
        'rate: $rate }';
  }

  @override
  String get name => 'respiratory_rate_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
