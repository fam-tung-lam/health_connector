part of 'health_record.dart';

/// A health record representing the user's respiratory rate.
///
/// Respiratory rate is the number of breaths a person takes per minute.
@sinceV1_3_0
@immutable
final class RespiratoryRateRecord extends InstantHealthRecord {
  const RespiratoryRateRecord({
    required super.time,
    required this.breathsPerMin,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// The number of breaths per minute.
  final Number breathsPerMin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord &&
          super == other &&
          breathsPerMin == other.breathsPerMin;

  @override
  int get hashCode => Object.hash(super.hashCode, breathsPerMin);

  @override
  String get name => 'respiratory_rate_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
