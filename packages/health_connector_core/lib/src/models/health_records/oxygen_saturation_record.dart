part of 'health_record.dart';

/// Represents an oxygen saturation (SpO₂) measurement at a specific point in
/// time.
///
/// [OxygenSaturationRecord] captures the fraction of oxygen-saturated
/// hemoglobin
/// relative to total hemoglobin in the blood. This measurement is expressed as
/// a
/// percentage (0.0 - 1.0) and is a vital sign indicating respiratory function.
///
/// ## Platform Mapping
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`OxygenSaturationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.oxygenSaturation`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)
///
/// ## Example
///
/// ```dart
/// final record = OxygenSaturationRecord(
///   time: DateTime.now(),
///   percentage: Percentage.fromWhole(98), // 98% SpO₂
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [OxygenSaturationHealthDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class OxygenSaturationRecord extends InstantHealthRecord {
  /// Creates an oxygen saturation record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the oxygen saturation was measured.
  /// - [percentage]: The oxygen saturation percentage (as decimal 0.0 - 1.0).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  const OxygenSaturationRecord({
    required super.time,
    required this.percentage,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The oxygen saturation percentage (0.0 - 1.0).
  final Percentage percentage;

  /// Creates a copy with the given fields replaced with the new values.
  OxygenSaturationRecord copyWith({
    DateTime? time,
    Percentage? percentage,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return OxygenSaturationRecord(
      time: time ?? this.time,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationRecord &&
          super == other &&
          percentage == other.percentage;

  @override
  int get hashCode => Object.hash(super.hashCode, percentage);
}
