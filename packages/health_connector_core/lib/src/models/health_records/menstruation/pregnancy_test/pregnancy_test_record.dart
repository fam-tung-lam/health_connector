part of '../../health_record.dart';

/// Represents a pregnancy test result at a specific point in time.
///
/// A pregnancy test record captures the result of a test that detects the
/// presence of human chorionic gonadotropin (hCG) hormone to determine
/// pregnancy status.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.pregnancyTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancytestresult)
///
/// ## Example
///
/// ```dart
/// final test = PregnancyTestRecord(
///   id: HealthRecordId.none,
///   time: DateTime(2024, 1, 15, 8, 30),
///   result: PregnancyTestResult.positive,
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [PregnancyTestDataType]
/// - [PregnancyTestResult]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class PregnancyTestRecord extends InstantHealthRecord {
  /// Creates a pregnancy test record.
  ///
  /// Records the result of a pregnancy test at a specific [time].
  /// The [result] indicates the test outcome (positive, negative,
  /// or inconclusive).
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  const PregnancyTestRecord({
    required super.time,
    required super.metadata,
    required this.result,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [PregnancyTestRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [PregnancyTestRecord] constructor, which enforces validation and business
  /// rules.
  @internalUse
  factory PregnancyTestRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required PregnancyTestResult result,
    int? zoneOffsetSeconds,
  }) {
    return PregnancyTestRecord._(
      id: id,
      time: time,
      metadata: metadata,
      result: result,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const PregnancyTestRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.result,
    super.zoneOffsetSeconds,
  });

  /// The pregnancy test result.
  ///
  /// Indicates the outcome of the test:
  /// - `positive`: Pregnancy detected (hCG hormone present)
  /// - `negative`: No pregnancy detected (hCG hormone absent)
  /// - `inconclusive`: Unable to determine result (test error or ambiguous)
  final PregnancyTestResult result;

  /// Creates a copy with the given fields replaced with the new values.
  PregnancyTestRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    PregnancyTestResult? result,
  }) {
    return PregnancyTestRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      result: result ?? this.result,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PregnancyTestRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          result == other.result;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      result.hashCode;
}
