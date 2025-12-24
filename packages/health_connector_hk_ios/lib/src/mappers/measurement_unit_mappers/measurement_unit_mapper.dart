import 'package:health_connector_core/health_connector_core_internal.dart'
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
        MeasurementUnitDto,
        MassUnitDto,
        EnergyUnitDto,
        TimeDurationUnitDto,
        LengthUnitDto,
        TemperatureUnitDto,
        PressureUnitDto,
        VelocityUnitDto,
        VolumeUnitDto,
        PowerUnitDto,
        BloodGlucoseUnitDto,
        PercentageUnitDto;
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
    // Inline conversion logic to avoid infinite recursion.
    // Calling `.toDomain()` on subtypes would resolve back to this extension.
    return switch (this) {
      MassDto(:final unit, :final value) => switch (unit) {
        MassUnitDto.kilograms => Mass.kilograms(value),
        MassUnitDto.grams => Mass.grams(value),
        MassUnitDto.pounds => Mass.pounds(value),
        MassUnitDto.ounces => Mass.ounces(value),
      },
      EnergyDto(:final unit, :final value) => switch (unit) {
        EnergyUnitDto.kilocalories => Energy.kilocalories(value),
        EnergyUnitDto.kilojoules => Energy.kilojoules(value),
        EnergyUnitDto.calories => Energy.calories(value),
        EnergyUnitDto.joules => Energy.joules(value),
      },
      TimeDurationDto(:final unit, :final value) => switch (unit) {
        TimeDurationUnitDto.seconds => TimeDuration.seconds(value),
        TimeDurationUnitDto.minutes => TimeDuration.minutes(value),
        TimeDurationUnitDto.hours => TimeDuration.hours(value),
      },
      LengthDto(:final unit, :final value) => switch (unit) {
        LengthUnitDto.meters => Length.meters(value),
        LengthUnitDto.kilometers => Length.kilometers(value),
        LengthUnitDto.miles => Length.miles(value),
        LengthUnitDto.feet => Length.feet(value),
        LengthUnitDto.inches => Length.inches(value),
      },
      TemperatureDto(:final unit, :final value) => switch (unit) {
        TemperatureUnitDto.celsius => Temperature.celsius(value),
        TemperatureUnitDto.fahrenheit => Temperature.fahrenheit(value),
        TemperatureUnitDto.kelvin => Temperature.kelvin(value),
      },
      PressureDto(:final unit, :final value) => switch (unit) {
        PressureUnitDto.millimetersOfMercury => Pressure.millimetersOfMercury(
          value,
        ),
      },
      VelocityDto(:final unit, :final value) => switch (unit) {
        VelocityUnitDto.metersPerSecond => Velocity.metersPerSecond(value),
        VelocityUnitDto.kilometersPerHour => Velocity.kilometersPerHour(value),
        VelocityUnitDto.milesPerHour => Velocity.milesPerHour(value),
      },
      VolumeDto(:final unit, :final value) => switch (unit) {
        VolumeUnitDto.liters => Volume.liters(value),
        VolumeUnitDto.milliliters => Volume.milliliters(value),
        VolumeUnitDto.fluidOuncesUs => Volume.fluidOuncesUs(value),
      },
      PowerDto(:final unit, :final value) => switch (unit) {
        PowerUnitDto.watts => Power.watts(value),
        PowerUnitDto.kilowatts => Power.kilowatts(value),
      },
      BloodGlucoseDto(:final unit, :final value) => switch (unit) {
        BloodGlucoseUnitDto.millimolesPerLiter =>
          BloodGlucose.millimolesPerLiter(value),
        BloodGlucoseUnitDto.milligramsPerDeciliter =>
          BloodGlucose.milligramsPerDeciliter(value),
      },
      NumberDto(:final value) => Number(value),
      PercentageDto(:final unit, :final value) => switch (unit) {
        PercentageUnitDto.decimal => Percentage.fromDecimal(value),
        PercentageUnitDto.whole => Percentage.fromWhole(value),
      },
    };
  }
}
