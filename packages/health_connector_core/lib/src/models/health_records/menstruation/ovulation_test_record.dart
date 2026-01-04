part of '../health_record.dart';

/// Represents an ovulation test result at a specific point in time.
///
/// An ovulation test record captures the result of a test that detects hormonal
/// changes to identify fertility windows. Tests typically measure luteinizing
/// hormone (LH) or estrogen levels.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`OvulationTestRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OvulationTestRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.ovulationTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/ovulationtestresult)
///
/// ## Example
///
/// ```dart
/// final test = OvulationTestRecord(
///   id: HealthRecordId.none,
///   time: DateTime(2024, 1, 15, 8, 30),
///   result: OvulationTestResultType.positive,
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [OvulationTestDataType]
/// - [OvulationTestResultType]
///
/// {@category Health Records}
@sinceV2_2_0
@immutable
final class OvulationTestRecord extends InstantHealthRecord {
  /// Creates an ovulation test record.
  ///
  /// Records the result of an ovulation test at a specific [time].
  /// The [result] indicates the test outcome (negative, inconclusive,
  /// high, or positive).
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  const OvulationTestRecord({
    required super.time,
    required super.metadata,
    required this.result,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The ovulation test result.
  ///
  /// Indicates the outcome of the test:
  /// - `negative`: No hormonal surge detected
  /// - `inconclusive`: Unable to determine result
  /// - `high`: Estrogen surge detected (approaching ovulation)
  /// - `positive`: LH surge detected (peak fertility, ovulation imminent)
  final OvulationTestResultType result;

  /// Creates a copy with the given fields replaced with the new values.
  OvulationTestRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    OvulationTestResultType? result,
  }) {
    return OvulationTestRecord(
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
      other is OvulationTestRecord &&
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

/// Represents the result of an ovulation test.
///
/// Ovulation tests detect hormonal changes to identify fertility windows.
/// This enum provides four possible test results.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `OvulationTestRecord.RESULT_*` constants
/// - **iOS HealthKit**: Maps to
///   `HKCategoryValueOvulationTestResult` enum values
///
/// {@category Health Records}
@sinceV2_2_0
enum OvulationTestResultType {
  /// Test result is negative (no hormonal surge detected).
  negative,

  /// Test result is inconclusive (unable to determine).
  inconclusive,

  /// Test result shows high estrogen levels (estrogen surge detected).
  high,

  /// Test result is positive (LH surge detected, peak fertility).
  positive,
}
