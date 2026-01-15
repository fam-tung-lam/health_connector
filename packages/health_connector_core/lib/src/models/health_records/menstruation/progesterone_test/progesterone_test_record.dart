part of '../../health_record.dart';

/// Represents a progesterone test result at a specific point in time.
///
/// A progesterone test record captures the result of a test that detects the
/// presence of progesterone hormone to confirm ovulation.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.progesteroneTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/progesteronetestresult)
///
/// ## Example
///
/// ```dart
/// final test = ProgesteroneTestRecord(
///   id: HealthRecordId.none,
///   time: DateTime(2024, 1, 15, 8, 30),
///   result: ProgesteroneTestResult.positive,
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [ProgesteroneTestDataType]
/// - [ProgesteroneTestResult]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ProgesteroneTestRecord extends InstantHealthRecord {
  /// Creates a progesterone test record.
  ///
  /// Records the result of a progesterone test at a specific [time].
  /// The [result] indicates the test outcome (positive, negative,
  /// or inconclusive).
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  const ProgesteroneTestRecord({
    required super.time,
    required super.metadata,
    required this.result,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [ProgesteroneTestRecord] instances without
  /// validation.
  ///
  /// Creates a [ProgesteroneTestRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [ProgesteroneTestRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory ProgesteroneTestRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required ProgesteroneTestResult result,
    int? zoneOffsetSeconds,
  }) {
    return ProgesteroneTestRecord._(
      id: id,
      time: time,
      metadata: metadata,
      result: result,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const ProgesteroneTestRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.result,
    super.zoneOffsetSeconds,
  });

  /// The progesterone test result.
  ///
  /// Indicates the outcome of the test:
  /// - `positive`: Progesterone detected (surge present)
  /// - `negative`: No progesterone detected (surge absent)
  /// - `inconclusive`: Unable to determine result (test error or ambiguous)
  final ProgesteroneTestResult result;

  /// Creates a copy with the given fields replaced with the new values.
  ProgesteroneTestRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    ProgesteroneTestResult? result,
  }) {
    return ProgesteroneTestRecord(
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
      other is ProgesteroneTestRecord &&
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
