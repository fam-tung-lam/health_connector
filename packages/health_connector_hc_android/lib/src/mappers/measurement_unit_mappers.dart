import 'package:health_connector_core/health_connector_core.dart'
    show
        Mass,
        Energy,
        Length,
        Temperature,
        Pressure,
        Velocity,
        Volume,
        Power,
        BloodGlucose,
        Numeric,
        Percentage,
        RespiratoryRate,
        Vo2Max,
        MeasurementUnit;
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show
        MassDto,
        MassUnitDto,
        EnergyDto,
        LengthDto,
        TemperatureDto,
        PressureDto,
        VelocityDto,
        VolumeDto,
        PowerDto,
        BloodGlucoseDto,
        NumericDto,
        PercentageDto,
        MeasurementUnitDto,
        EnergyUnitDto,
        LengthUnitDto,
        TemperatureUnitDto,
        PressureUnitDto,
        VelocityUnitDto,
        VolumeUnitDto,
        PowerUnitDto,
        BloodGlucoseUnitDto,
        NumericUnitDto,
        PercentageUnitDto,
        Vo2MaxDto,
        Vo2MaxUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MeasurementUnit] to [MeasurementUnitDto].
@internal
extension MeasurementUnitToDto on MeasurementUnit {
  MeasurementUnitDto toDto() {
    switch (this) {
      case final Mass unit:
        // Uses kilograms as the transfer unit for consistency.
        return MassDto(value: unit.inKilograms, unit: MassUnitDto.kilograms);
      case final Energy unit:
        // Uses kilocalories as the transfer unit for consistency.
        return EnergyDto(
          value: unit.inKilocalories,
          unit: EnergyUnitDto.kilocalories,
        );
      case final Length unit:
        // Uses meters as the transfer unit for consistency.
        return LengthDto(value: unit.inMeters, unit: LengthUnitDto.meters);
      case final Temperature unit:
        // Uses celsius as the transfer unit for consistency.
        return TemperatureDto(
          value: unit.inCelsius,
          unit: TemperatureUnitDto.celsius,
        );
      case final Pressure unit:
        // Uses millimeters of mercury as the transfer unit.
        return PressureDto(
          value: unit.inMillimetersOfMercury,
          unit: PressureUnitDto.millimetersOfMercury,
        );
      case final Velocity unit:
        // Uses meters per second as the transfer unit for consistency.
        return VelocityDto(
          value: unit.inMetersPerSecond,
          unit: VelocityUnitDto.metersPerSecond,
        );
      case final Volume unit:
        // Uses liters as the transfer unit for consistency.
        return VolumeDto(value: unit.inLiters, unit: VolumeUnitDto.liters);
      case final Power unit:
        // Uses watts as the transfer unit for consistency.
        return PowerDto(value: unit.inWatts, unit: PowerUnitDto.watts);
      case final BloodGlucose unit:
        // Uses millimoles per liter as the transfer unit for consistency.
        return BloodGlucoseDto(
          value: unit.inMillimolesPerLiter,
          unit: BloodGlucoseUnitDto.millimolesPerLiter,
        );
      case final Numeric unit:
        return NumericDto(
          value: unit.value.toDouble(),
          unit: NumericUnitDto.numeric,
        );
      case final Percentage unit:
        // Uses decimal as the transfer unit for consistency.
        return PercentageDto(
          value: unit.asDecimal,
          unit: PercentageUnitDto.decimal,
        );
      case final RespiratoryRate unit:
        return NumericDto(
          value: unit.breathsPerMinute,
          unit: NumericUnitDto.numeric,
        );
      case final Vo2Max unit:
        // Uses milliliters per kilogram per minute as the transfer unit.
        return Vo2MaxDto(
          value: unit.value,
          unit: Vo2MaxUnitDto.millilitersPerKilogramPerMinute,
        );
    }
  }
}

/// Converts [MeasurementUnitDto] to [MeasurementUnit].
@internal
extension MeasurementUnitDtoToDomain on MeasurementUnitDto {
  MeasurementUnit toDomain() {
    switch (this) {
      case final MassDto dto:
        switch (dto.unit) {
          case MassUnitDto.kilograms:
            return Mass.kilograms(dto.value);
          case MassUnitDto.grams:
            return Mass.grams(dto.value);
          case MassUnitDto.pounds:
            return Mass.pounds(dto.value);
          case MassUnitDto.ounces:
            return Mass.ounces(dto.value);
        }
      case final EnergyDto dto:
        switch (dto.unit) {
          case EnergyUnitDto.kilocalories:
            return Energy.kilocalories(dto.value);
          case EnergyUnitDto.kilojoules:
            return Energy.kilojoules(dto.value);
          case EnergyUnitDto.calories:
            return Energy.calories(dto.value);
          case EnergyUnitDto.joules:
            return Energy.joules(dto.value);
        }
      case final LengthDto dto:
        switch (dto.unit) {
          case LengthUnitDto.meters:
            return Length.meters(dto.value);
          case LengthUnitDto.kilometers:
            return Length.kilometers(dto.value);
          case LengthUnitDto.miles:
            return Length.miles(dto.value);
          case LengthUnitDto.feet:
            return Length.feet(dto.value);
          case LengthUnitDto.inches:
            return Length.inches(dto.value);
        }
      case final TemperatureDto dto:
        switch (dto.unit) {
          case TemperatureUnitDto.celsius:
            return Temperature.celsius(dto.value);
          case TemperatureUnitDto.fahrenheit:
            return Temperature.fahrenheit(dto.value);
          case TemperatureUnitDto.kelvin:
            return Temperature.kelvin(dto.value);
        }
      case final PressureDto dto:
        switch (dto.unit) {
          case PressureUnitDto.millimetersOfMercury:
            return Pressure.millimetersOfMercury(dto.value);
        }
      case final VelocityDto dto:
        switch (dto.unit) {
          case VelocityUnitDto.metersPerSecond:
            return Velocity.metersPerSecond(dto.value);
          case VelocityUnitDto.kilometersPerHour:
            return Velocity.kilometersPerHour(dto.value);
          case VelocityUnitDto.milesPerHour:
            return Velocity.milesPerHour(dto.value);
        }
      case final VolumeDto dto:
        switch (dto.unit) {
          case VolumeUnitDto.liters:
            return Volume.liters(dto.value);
          case VolumeUnitDto.milliliters:
            return Volume.milliliters(dto.value);
          case VolumeUnitDto.fluidOuncesUs:
            return Volume.fluidOuncesUs(dto.value);
        }
      case final PowerDto dto:
        switch (dto.unit) {
          case PowerUnitDto.watts:
            return Power.watts(dto.value);
          case PowerUnitDto.kilowatts:
            return Power.kilowatts(dto.value);
        }
      case final BloodGlucoseDto dto:
        switch (dto.unit) {
          case BloodGlucoseUnitDto.millimolesPerLiter:
            return BloodGlucose.millimolesPerLiter(dto.value);
          case BloodGlucoseUnitDto.milligramsPerDeciliter:
            return BloodGlucose.milligramsPerDeciliter(dto.value);
        }
      case final NumericDto dto:
        return Numeric(dto.value);
      case final PercentageDto dto:
        switch (dto.unit) {
          case PercentageUnitDto.decimal:
            return Percentage.fromDecimal(dto.value);
          case PercentageUnitDto.whole:
            return Percentage.fromWhole(dto.value);
        }
      case final Vo2MaxDto dto:
        switch (dto.unit) {
          case Vo2MaxUnitDto.millilitersPerKilogramPerMinute:
            return Vo2Max.millilitersPerKilogramPerMinute(dto.value);
        }
    }
  }
}
