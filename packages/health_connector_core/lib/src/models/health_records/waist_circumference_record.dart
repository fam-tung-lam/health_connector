part of 'health_record.dart';

/// Represents a waist circumference measurement at a specific point in time.
///
/// Waist circumference is a measurement around the abdomen at the level of
/// the navel. It is an important indicator of abdominal obesity and associated
/// health risks, particularly for conditions such as cardiovascular disease
/// and type 2 diabetes.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.waistCircumference`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/waistcir
/// cumference)
///
/// ## Example
///
/// ```dart
/// final record = WaistCircumferenceRecord(
///   time: DateTime.now(),
///   circumference: Length.meters(0.85), // 85 cm
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [WaistCircumferenceDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class WaistCircumferenceRecord extends InstantHealthRecord {
  /// Minimum valid waist circumference (20.0 cm).
  ///
  /// Newborn/infant lower bound.
  static const Length minCircumference = Length.centimeters(20.0);

  /// Maximum valid waist circumference (200.0 cm).
  ///
  /// Severe obesity upper limit.
  static const Length maxCircumference = Length.centimeters(200.0);

  /// Creates a waist circumference record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the circumference was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [circumference]: The waist circumference.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [circumference] is outside the valid range of
  ///   [minCircumference]-[maxCircumference] cm.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minCircumference] cm)**: Newborn/infant lower bound.
  /// - **Maximum ([maxCircumference] cm)**: Severe obesity upper limit.
  WaistCircumferenceRecord({
    required super.time,
    required super.metadata,
    required this.circumference,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition:
          circumference >= minCircumference &&
          circumference <= maxCircumference,
      value: circumference,
      name: 'circumference',
      message:
          'Waist circumference must be between '
          '${minCircumference.inCentimeters.toStringAsFixed(1)}-'
          '${maxCircumference.inCentimeters.toStringAsFixed(0)} cm. '
          'Got ${circumference.inCentimeters.toStringAsFixed(1)} cm.',
    );
  }

  /// Internal factory for creating [WaistCircumferenceRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WaistCircumferenceRecord] constructor, which enforces validation.
  @internalUse
  factory WaistCircumferenceRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Length circumference,
    int? zoneOffsetSeconds,
  }) {
    return WaistCircumferenceRecord._(
      time: time,
      metadata: metadata,
      circumference: circumference,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  WaistCircumferenceRecord._({
    required super.time,
    required super.metadata,
    required this.circumference,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The waist circumference.
  final Length circumference;

  /// Creates a copy with the given fields replaced with the new values.
  WaistCircumferenceRecord copyWith({
    DateTime? time,
    Length? circumference,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return WaistCircumferenceRecord(
      time: time ?? this.time,
      circumference: circumference ?? this.circumference,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaistCircumferenceRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          circumference == other.circumference &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      circumference.hashCode ^
      metadata.hashCode;
}
