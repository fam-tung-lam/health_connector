import 'package:health_connector_core/health_connector_core.dart'
    show
        Mass,
        Energy,
        TimeDuration,
        Length,
        Temperature,
        Pressure,
        Velocity,
        Volume,
        Power,
        BloodGlucose,
        Number,
        Percentage,
        MeasurementUnit,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/energy_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/length_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/mass_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/number_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/percentage_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/power_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/pressure_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/temperature_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/time_duration_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/velocity_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/volume_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        MassDto,
        EnergyDto,
        TimeDurationDto,
        LengthDto,
        TemperatureDto,
        PressureDto,
        VelocityDto,
        VolumeDto,
        PowerDto,
        BloodGlucoseDto,
        NumberDto,
        PercentageDto,
        MeasurementUnitDto;
import 'package:meta/meta.dart' show internal;

export 'blood_glucose_mapper.dart';
export 'energy_mapper.dart';
export 'length_mapper.dart';
export 'mass_mapper.dart';
export 'number_mapper.dart';
export 'percentage_mapper.dart';
export 'power_mapper.dart';
export 'pressure_mapper.dart';
export 'temperature_mapper.dart';
export 'time_duration_mapper.dart';
export 'velocity_mapper.dart';
export 'volume_mapper.dart';

/// Converts [MeasurementUnit] to [MeasurementUnitDto].
@sinceV1_0_0
@internal
extension MeasurementUnitToDto on MeasurementUnit {
  MeasurementUnitDto toDto() {
    switch (this) {
      case final Mass unit:
        return unit.toDto();
      case final Energy unit:
        return unit.toDto();
      case final TimeDuration unit:
        return unit.toDto();
      case final Length unit:
        return unit.toDto();
      case final Temperature unit:
        return unit.toDto();
      case final Pressure unit:
        return unit.toDto();
      case final Velocity unit:
        return unit.toDto();
      case final Volume unit:
        return unit.toDto();
      case final Power unit:
        return unit.toDto();
      case final BloodGlucose unit:
        return unit.toDto();
      case final Number unit:
        return unit.toDto();
      case final Percentage unit:
        return unit.toDto();
    }
  }
}

/// Converts [MeasurementUnitDto] to [MeasurementUnit].
@sinceV1_0_0
@internal
extension MeasurementUnitDtoToDomain on MeasurementUnitDto {
  MeasurementUnit toDomain() {
    switch (this) {
      case final MassDto dto:
        return dto.toDomain();
      case final EnergyDto dto:
        return dto.toDomain();
      case final TimeDurationDto dto:
        return dto.toDomain();
      case final LengthDto dto:
        return dto.toDomain();
      case final TemperatureDto dto:
        return dto.toDomain();
      case final PressureDto dto:
        return dto.toDomain();
      case final VelocityDto dto:
        return dto.toDomain();
      case final VolumeDto dto:
        return dto.toDomain();
      case final PowerDto dto:
        return dto.toDomain();
      case final BloodGlucoseDto dto:
        return dto.toDomain();
      case final NumberDto dto:
        return dto.toDomain();
      case final PercentageDto dto:
        return dto.toDomain();
    }
  }
}
