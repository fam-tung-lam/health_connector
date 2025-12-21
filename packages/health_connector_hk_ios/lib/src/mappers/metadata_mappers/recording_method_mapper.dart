import 'package:health_connector_core/health_connector_core.dart'
    show RecordingMethod, sinceV1_0_0;
import 'package:meta/meta.dart' show internal;

/// Converts [RecordingMethod] to HealthKit's manual entry flag.
@sinceV1_0_0
@internal
extension RecordingMethodDtoMapper on RecordingMethod {
  /// Converts [RecordingMethod] to a boolean indicating manual entry.
  ///
  /// HealthKit only uses a boolean flag to indicate whether data was
  /// manually entered.
  bool toIsManualEntry() {
    return this == RecordingMethod.manualEntry;
  }
}

/// Converts HealthKit's manual entry flag to [RecordingMethod].
@sinceV1_0_0
@internal
extension RecordingMethodFromDto on bool {
  /// Converts a manual entry flag to [RecordingMethod].
  ///
  /// Returns [RecordingMethod.manualEntry] if true,
  /// otherwise [RecordingMethod.unknown].
  RecordingMethod toRecordingMethod() {
    return this ? RecordingMethod.manualEntry : RecordingMethod.unknown;
  }
}
