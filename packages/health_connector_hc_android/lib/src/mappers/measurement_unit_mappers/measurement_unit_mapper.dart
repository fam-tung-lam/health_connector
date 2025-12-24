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
        BloodGlucoseUnitDto.milligramsPerDeciliter =>
          BloodGlucose.milligramsPerDeciliter(value),
        BloodGlucoseUnitDto.millimolesPerLiter =>
          BloodGlucose.millimolesPerLiter(value),
      },
      NumberDto(:final value) => Number(value),
      PercentageDto(:final unit, :final value) => switch (unit) {
        PercentageUnitDto.decimal => Percentage.fromDecimal(value),
        PercentageUnitDto.whole => Percentage.fromWhole(value),
      },
    };
  }
}
