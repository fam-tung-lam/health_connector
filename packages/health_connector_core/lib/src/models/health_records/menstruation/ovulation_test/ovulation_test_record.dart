part of '../../health_record.dart';

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
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [OvulationTestDataType]
/// - [OvulationTestResult]
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
  final OvulationTestResult result;

  /// Creates a copy with the given fields replaced with the new values.
  OvulationTestRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    OvulationTestResult? result,
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
