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
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
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
    return switch (this) {
      final Mass mass => mass.toDto(),
      final Energy energy => energy.toDto(),
      final TimeDuration timeDuration => timeDuration.toDto(),
      final Length length => length.toDto(),
      final Temperature temperature => temperature.toDto(),
      final Pressure pressure => pressure.toDto(),
      final Velocity velocity => velocity.toDto(),
      final Volume volume => volume.toDto(),
      final Power power => power.toDto(),
      final BloodGlucose bloodGlucose => bloodGlucose.toDto(),
      final Number number => number.toDto(),
      final Percentage percentage => percentage.toDto(),
    };
  }
}

/// Converts [MeasurementUnitDto] to [MeasurementUnit].
@sinceV1_0_0
@internal
extension MeasurementUnitDtoToDomain on MeasurementUnitDto {
  MeasurementUnit toDomain() {
    return switch (this) {
      final MassDto massDto => massDto.toDomain(),
      final EnergyDto energyDto => energyDto.toDomain(),
      final TimeDurationDto timeDurationDto => timeDurationDto.toDomain(),
      final LengthDto lengthDto => lengthDto.toDomain(),
      final TemperatureDto temperatureDto => temperatureDto.toDomain(),
      final PressureDto pressureDto => pressureDto.toDomain(),
      final VelocityDto velocityDto => velocityDto.toDomain(),
      final VolumeDto volumeDto => volumeDto.toDomain(),
      final PowerDto powerDto => powerDto.toDomain(),
      final BloodGlucoseDto bloodGlucoseDto => bloodGlucoseDto.toDomain(),
      final NumberDto numberDto => numberDto.toDomain(),
      final PercentageDto percentageDto => percentageDto.toDomain(),
    };
  }
}
