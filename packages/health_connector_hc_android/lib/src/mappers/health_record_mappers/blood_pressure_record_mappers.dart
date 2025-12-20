import 'package:health_connector_core/health_connector_core.dart'
    show
        BloodPressureRecord,
        Pressure,
        HealthRecordId,
        BloodPressureMeasurementLocation,
        BloodPressureBodyPosition,
        sinceV1_2_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        BloodPressureRecordDto,
        PressureDto,
        MeasurementLocationDto,
        BodyPositionDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodPressureRecord] to [BloodPressureRecordDto].
@sinceV1_2_0
@internal
extension BloodPressureRecordToDto on BloodPressureRecord {
  BloodPressureRecordDto toDto() {
    return BloodPressureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      systolic: systolic.toDto() as PressureDto,
      diastolic: diastolic.toDto() as PressureDto,
      bodyPosition: bodyPosition.toDto(),
      measurementLocation: measurementLocation.toDto(),
    );
  }
}

/// Converts [BloodPressureRecordDto] to [BloodPressureRecord].
@sinceV1_2_0
@internal
extension BloodPressureRecordDtoToDomain on BloodPressureRecordDto {
  BloodPressureRecord toDomain() {
    return BloodPressureRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      systolic: systolic.toDomain() as Pressure,
      diastolic: diastolic.toDomain() as Pressure,
      bodyPosition: bodyPosition.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
    );
  }
}

/// Converts [BloodPressureBodyPosition] to [BodyPositionDto].
@sinceV1_2_0
@internal
extension BloodPressureBodyPositionToDto on BloodPressureBodyPosition {
  BodyPositionDto toDto() {
    switch (this) {
      case BloodPressureBodyPosition.unknown:
        return BodyPositionDto.unknown;
      case BloodPressureBodyPosition.standingUp:
        return BodyPositionDto.standingUp;
      case BloodPressureBodyPosition.sittingDown:
        return BodyPositionDto.sittingDown;
      case BloodPressureBodyPosition.lyingDown:
        return BodyPositionDto.lyingDown;
      case BloodPressureBodyPosition.reclining:
        return BodyPositionDto.reclining;
    }
  }
}

/// Converts [BodyPositionDto] to [BloodPressureBodyPosition].
@sinceV1_2_0
@internal
extension BodyPositionDtoToDomain on BodyPositionDto {
  BloodPressureBodyPosition toDomain() {
    switch (this) {
      case BodyPositionDto.unknown:
        return BloodPressureBodyPosition.unknown;
      case BodyPositionDto.standingUp:
        return BloodPressureBodyPosition.standingUp;
      case BodyPositionDto.sittingDown:
        return BloodPressureBodyPosition.sittingDown;
      case BodyPositionDto.lyingDown:
        return BloodPressureBodyPosition.lyingDown;
      case BodyPositionDto.reclining:
        return BloodPressureBodyPosition.reclining;
    }
  }
}

/// Converts [BloodPressureMeasurementLocation] to [MeasurementLocationDto].
@sinceV1_2_0
@internal
extension BloodPressureMeasurementLocationToDto
    on BloodPressureMeasurementLocation {
  MeasurementLocationDto toDto() {
    switch (this) {
      case BloodPressureMeasurementLocation.unknown:
        return MeasurementLocationDto.unknown;
      case BloodPressureMeasurementLocation.leftWrist:
        return MeasurementLocationDto.leftWrist;
      case BloodPressureMeasurementLocation.rightWrist:
        return MeasurementLocationDto.rightWrist;
      case BloodPressureMeasurementLocation.leftUpperArm:
        return MeasurementLocationDto.leftUpperArm;
      case BloodPressureMeasurementLocation.rightUpperArm:
        return MeasurementLocationDto.rightUpperArm;
    }
  }
}

/// Converts [MeasurementLocationDto] to [BloodPressureMeasurementLocation].
@sinceV1_2_0
@internal
extension MeasurementLocationDtoToDomain on MeasurementLocationDto {
  BloodPressureMeasurementLocation toDomain() {
    switch (this) {
      case MeasurementLocationDto.unknown:
        return BloodPressureMeasurementLocation.unknown;
      case MeasurementLocationDto.leftWrist:
        return BloodPressureMeasurementLocation.leftWrist;
      case MeasurementLocationDto.rightWrist:
        return BloodPressureMeasurementLocation.rightWrist;
      case MeasurementLocationDto.leftUpperArm:
        return BloodPressureMeasurementLocation.leftUpperArm;
      case MeasurementLocationDto.rightUpperArm:
        return BloodPressureMeasurementLocation.rightUpperArm;
    }
  }
}
