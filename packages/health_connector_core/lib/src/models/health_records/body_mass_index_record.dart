part of 'health_record.dart';

/// Represents a body mass index (BMI) measurement at a specific point in time.
///
/// Body Mass Index is a value derived from the mass and height of a person.
/// The BMI is defined as the body mass divided by the square of the body height.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.bodyMassIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)
///
/// ## Example
///
/// ```dart
/// final record = BodyMassIndexRecord(
///   time: DateTime.now(),
///   bodyMassIndex: Number(22.5),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BodyMassIndexHealthDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class BodyMassIndexRecord extends InstantHealthRecord {
  /// Creates a body mass index record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the BMI was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [bodyMassIndex]: The BMI value (kg/m^2).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [bodyMassIndex] is negative.
  factory BodyMassIndexRecord({
    required DateTime time,
    required Metadata metadata,
    required Number bodyMassIndex,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
    if (bodyMassIndex < Number.zero) {
      throw ArgumentError.value(
        bodyMassIndex,
        'bodyMassIndex',
        'Body mass index must be non-negative',
      );
    }
    return BodyMassIndexRecord._(
      time: time,
      metadata: metadata,
      bodyMassIndex: bodyMassIndex,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor for internal use.
  const BodyMassIndexRecord._({
    required super.time,
    required super.metadata,
    required this.bodyMassIndex,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The body mass index value (kg/m^2).
  final Number bodyMassIndex;

  /// Creates a copy with the given fields replaced with the new values.
  BodyMassIndexRecord copyWith({
    DateTime? time,
    Number? bodyMassIndex,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyMassIndexRecord._(
      time: time ?? this.time,
      bodyMassIndex: bodyMassIndex ?? this.bodyMassIndex,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyMassIndexRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          bodyMassIndex == other.bodyMassIndex &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      bodyMassIndex.hashCode ^
      metadata.hashCode;
}
