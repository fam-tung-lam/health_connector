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
        Frequency,
        MeasurementUnit,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/energy_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/frequency_mapper.dart';
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
        FrequencyDto,
        MeasurementUnitDto;
import 'package:meta/meta.dart' show internal;

export 'blood_glucose_mapper.dart';
export 'energy_mapper.dart';
export 'frequency_mapper.dart';
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

/// ## ⚠️ CRITICAL: Infinite Recursion Prevention
///
/// This extension uses **explicit extension invocation** to prevent infinite
/// recursion bugs caused by missing extension imports.
///
/// ### The Problem
///
/// Each [MeasurementUnit] subclass has its own `toDto()` extension method
/// defined in a separate file (e.g., `MassToDto` in `mass_mapper.dart`).
/// If you forget to import one of these files, Dart's extension resolution
/// will fall back to this base extension, causing infinite recursion:
///
/// ```dart
/// // ❌ DANGEROUS: Implicit extension invocation
/// case final Mass mass:
///   return mass.toDto();  // If import missing, calls THIS method again!
/// ```
///
/// ### The Solution
///
/// We use explicit extension invocation to force compile-time errors when
/// imports are missing:
///
/// ```dart
/// // ✅ SAFE: Explicit extension invocation
/// case final Mass mass:
///   return MassToDto(mass).toDto();  // Compile error if import missing
/// ```
///
/// ### For Developers
///
/// When adding a new [MeasurementUnit] subclass:
///
/// 1. Create a new mapper file with the extension (e.g., `FooToDto`)
/// 2. Import the mapper file at the top of this file
/// 3. Add a case using **explicit extension invocation**:
///    ```dart
///    case final Foo foo:
///      return FooToDto(foo).toDto();
///    ```
/// 4. **Never** use implicit invocation (`foo.toDto()`) - it will compile
///    but cause infinite recursion if the import is missing
///
/// The same approach must be applied to [MeasurementUnitDtoToDomain].

/// Converts [MeasurementUnit] to [MeasurementUnitDto].
@sinceV1_0_0
@internal
extension MeasurementUnitToDto on MeasurementUnit {
  MeasurementUnitDto toDto() {
    return switch (this) {
      final Mass mass => MassToDto(mass).toDto(),
      final Energy energy => EnergyToDto(energy).toDto(),
      final TimeDuration timeDuration => TimeDurationToDto(
        timeDuration,
      ).toDto(),
      final Length length => LengthToDto(length).toDto(),
      final Temperature temperature => TemperatureToDto(temperature).toDto(),
      final Pressure pressure => PressureToDto(pressure).toDto(),
      final Velocity velocity => VelocityToDto(velocity).toDto(),
      final Volume volume => VolumeToDto(volume).toDto(),
      final Power power => PowerToDto(power).toDto(),
      final BloodGlucose bloodGlucose => BloodGlucoseToDto(
        bloodGlucose,
      ).toDto(),
      final Number number => NumberToDto(number).toDto(),
      final Percentage percentage => PercentageToDto(percentage).toDto(),
      final Frequency frequency => FrequencyToDto(frequency).toDto(),
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
      MassDto(:final kilograms) => Mass.kilograms(kilograms),
      EnergyDto(:final kilocalories) => Energy.kilocalories(kilocalories),
      TimeDurationDto(:final seconds) => TimeDuration.seconds(seconds),
      LengthDto(:final meters) => Length.meters(meters),
      TemperatureDto(:final celsius) => Temperature.celsius(celsius),
      PressureDto(:final millimetersOfMercury) => Pressure.millimetersOfMercury(
        millimetersOfMercury,
      ),
      VelocityDto(:final metersPerSecond) => Velocity.metersPerSecond(
        metersPerSecond,
      ),
      VolumeDto(:final liters) => Volume.liters(liters),
      PowerDto(:final watts) => Power.watts(watts),
      BloodGlucoseDto(:final millimolesPerLiter) =>
        BloodGlucose.millimolesPerLiter(millimolesPerLiter),
      NumberDto(:final value) => Number(value),
      PercentageDto(:final decimal) => Percentage.fromDecimal(decimal),
      FrequencyDto(:final perMinute) => Frequency.perMinute(perMinute),
    };
  }
}
