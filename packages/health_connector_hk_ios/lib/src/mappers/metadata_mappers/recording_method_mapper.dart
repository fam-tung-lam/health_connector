import 'package:health_connector_core/health_connector_core_internal.dart'
    show RecordingMethod;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show RecordingMethodDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RecordingMethod] to [RecordingMethodDto].
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
