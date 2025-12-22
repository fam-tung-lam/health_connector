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

  /// Creates a copy with the given fields replaced with the new values.
  RespiratoryRateRecord copyWith({
    DateTime? time,
    Number? breathsPerMin,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RespiratoryRateRecord(
      time: time ?? this.time,
      breathsPerMin: breathsPerMin ?? this.breathsPerMin,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord &&
          super == other &&
          breathsPerMin == other.breathsPerMin;

  @override
  int get hashCode => Object.hash(super.hashCode, breathsPerMin);

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
