import 'package:health_connector_core/health_connector_core.dart'
    show RecordingMethod, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show RecordingMethodDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RecordingMethod] to [RecordingMethodDto].
@sinceV1_0_0
@internal
extension RecordingMethodDtoMapper on RecordingMethod {
  RecordingMethodDto toDto() {
    switch (this) {
      case RecordingMethod.unknown:
        return RecordingMethodDto.unknown;
      case RecordingMethod.manualEntry:
        return RecordingMethodDto.manualEntry;
      case RecordingMethod.automaticallyRecorded:
        return RecordingMethodDto.automaticallyRecorded;
      case RecordingMethod.activelyRecorded:
        return RecordingMethodDto.activelyRecorded;
    }
  }
}

/// Converts [RecordingMethodDto] to [RecordingMethod].
@sinceV1_0_0
@internal
extension RecordingMethodDtoToDomain on RecordingMethodDto {
  RecordingMethod toDomain() {
    switch (this) {
      case RecordingMethodDto.unknown:
        return RecordingMethod.unknown;
      case RecordingMethodDto.manualEntry:
        return RecordingMethod.manualEntry;
      case RecordingMethodDto.automaticallyRecorded:
        return RecordingMethod.automaticallyRecorded;
      case RecordingMethodDto.activelyRecorded:
        return RecordingMethod.activelyRecorded;
    }
  }
}
