package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.units.BloodGlucose
import androidx.health.connect.client.units.Energy
import androidx.health.connect.client.units.Length
import androidx.health.connect.client.units.Mass
import androidx.health.connect.client.units.Percentage
import androidx.health.connect.client.units.Power
import androidx.health.connect.client.units.Pressure
import androidx.health.connect.client.units.Temperature
import androidx.health.connect.client.units.Velocity
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.NumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.NumericUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageDto
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationDto
import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityDto
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeUnitDto
import kotlin.time.Duration
import kotlin.time.Duration.Companion.hours
import kotlin.time.Duration.Companion.minutes
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit

/**
 * Kelvin to Celsius conversion constant.
 */
private const val KELVIN_TO_CELSIUS_OFFSET = 273.15

/**
 * Conversion factor from kilowatts to watts.
 */
private const val KILOWATTS_TO_WATTS = 1000

/**
 * Conversion factor from whole percentage (0-100) to decimal (0.0-1.0).
 */
private const val PERCENTAGE_WHOLE_TO_DECIMAL = 100.0

/**
 * Converts a [MassDto] to a Health Connect [Mass] object.
 */
internal fun MassDto.toHealthConnect(): Mass = when (unit) {
    MassUnitDto.KILOGRAMS -> Mass.kilograms(value)
    MassUnitDto.GRAMS -> Mass.grams(value)
    MassUnitDto.POUNDS -> Mass.pounds(value)
    MassUnitDto.OUNCES -> Mass.ounces(value)
}

/**
 * Converts a Health Connect [Mass] object to a [MassDto].
 *
 * Uses kilograms as the transfer unit for consistency.
 */
internal fun Mass.toDto(): MassDto = MassDto(
    value = inKilograms,
    unit = MassUnitDto.KILOGRAMS,
)

/**
 * Converts an [EnergyDto] to a Health Connect [Energy] object.
 */
internal fun EnergyDto.toHealthConnect(): Energy = when (unit) {
    EnergyUnitDto.KILOCALORIES -> Energy.kilocalories(value)
    EnergyUnitDto.KILOJOULES -> Energy.kilojoules(value)
    EnergyUnitDto.CALORIES -> Energy.calories(value)
    EnergyUnitDto.JOULES -> Energy.joules(value)
}

/**
 * Converts a Health Connect [Energy] object to an [EnergyDto].
 *
 * Uses kilocalories as the transfer unit for consistency.
 */
internal fun Energy.toDto(): EnergyDto = EnergyDto(
    value = inKilocalories,
    unit = EnergyUnitDto.KILOCALORIES,
)

/**
 * Converts a [LengthDto] to a Health Connect [Length] object.
 */
internal fun LengthDto.toHealthConnect(): Length = when (unit) {
    LengthUnitDto.METERS -> Length.meters(value)
    LengthUnitDto.KILOMETERS -> Length.kilometers(value)
    LengthUnitDto.MILES -> Length.miles(value)
    LengthUnitDto.FEET -> Length.feet(value)
    LengthUnitDto.INCHES -> Length.inches(value)
}

/**
 * Converts a Health Connect [Length] object to a [LengthDto].
 *
 * Uses meters as the transfer unit for consistency.
 */
internal fun Length.toDto(): LengthDto = LengthDto(
    value = inMeters,
    unit = LengthUnitDto.METERS,
)

/**
 * Converts a [TemperatureDto] to a Health Connect [Temperature] object.
 */
internal fun TemperatureDto.toHealthConnect(): Temperature = when (unit) {
    TemperatureUnitDto.CELSIUS -> Temperature.celsius(value)
    TemperatureUnitDto.FAHRENHEIT -> Temperature.fahrenheit(value)
    TemperatureUnitDto.KELVIN -> Temperature.celsius(value - KELVIN_TO_CELSIUS_OFFSET)
}

/**
 * Converts a Health Connect [Temperature] object to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Temperature.toDto(): TemperatureDto = TemperatureDto(
    value = inCelsius,
    unit = TemperatureUnitDto.CELSIUS,
)

/**
 * Converts a [PressureDto] to a Health Connect [Pressure] object.
 */
internal fun PressureDto.toHealthConnect(): Pressure = when (unit) {
    PressureUnitDto.MILLIMETERS_OF_MERCURY -> Pressure.millimetersOfMercury(value)
}

/**
 * Converts a Health Connect [Pressure] object to a [PressureDto].
 *
 * Uses millimeters of mercury as the transfer unit.
 */
internal fun Pressure.toDto(): PressureDto = PressureDto(
    value = inMillimetersOfMercury,
    unit = PressureUnitDto.MILLIMETERS_OF_MERCURY,
)

/**
 * Converts a [VelocityDto] to a Health Connect [Velocity] object.
 */
internal fun VelocityDto.toHealthConnect(): Velocity = when (unit) {
    VelocityUnitDto.METERS_PER_SECOND -> Velocity.metersPerSecond(value)
    VelocityUnitDto.KILOMETERS_PER_HOUR -> Velocity.kilometersPerHour(value)
    VelocityUnitDto.MILES_PER_HOUR -> Velocity.milesPerHour(value)
}

/**
 * Converts a Health Connect [Velocity] object to a [VelocityDto].
 *
 * Uses meters per second as the transfer unit for consistency.
 */
internal fun Velocity.toDto(): VelocityDto = VelocityDto(
    value = inMetersPerSecond,
    unit = VelocityUnitDto.METERS_PER_SECOND,
)

/**
 * Converts a [VolumeDto] to a Health Connect [Volume] object.
 */
internal fun VolumeDto.toHealthConnect(): Volume = when (unit) {
    VolumeUnitDto.LITERS -> Volume.liters(value)
    VolumeUnitDto.MILLILITERS -> Volume.milliliters(value)
    VolumeUnitDto.FLUID_OUNCES_US -> Volume.fluidOuncesUs(value)
}

/**
 * Converts a Health Connect [Volume] object to a [VolumeDto].
 *
 * Uses liters as the transfer unit for consistency.
 */
internal fun Volume.toDto(): VolumeDto = VolumeDto(
    value = inLiters,
    unit = VolumeUnitDto.LITERS,
)

/**
 * Converts a [PowerDto] to a Health Connect [Power] object.
 */
internal fun PowerDto.toHealthConnect(): Power = when (unit) {
    PowerUnitDto.WATTS -> Power.watts(value)
    PowerUnitDto.KILOWATTS -> Power.watts(value * KILOWATTS_TO_WATTS)
}

/**
 * Converts a Health Connect [Power] object to a [PowerDto].
 *
 * Uses watts as the transfer unit for consistency.
 */
internal fun Power.toDto(): PowerDto = PowerDto(
    value = inWatts,
    unit = PowerUnitDto.WATTS,
)

/**
 * Converts a [BloodGlucoseDto] to a Health Connect [BloodGlucose] object.
 */
internal fun BloodGlucoseDto.toHealthConnect(): BloodGlucose = when (unit) {
    BloodGlucoseUnitDto.MILLIMOLES_PER_LITER -> BloodGlucose.millimolesPerLiter(value)
    BloodGlucoseUnitDto.MILLIGRAMS_PER_DECILITER -> BloodGlucose.milligramsPerDeciliter(value)
}

/**
 * Converts a Health Connect [BloodGlucose] object to a [BloodGlucoseDto].
 *
 * Uses millimoles per liter as the transfer unit for consistency.
 */
internal fun BloodGlucose.toDto(): BloodGlucoseDto = BloodGlucoseDto(
    value = inMillimolesPerLiter,
    unit = BloodGlucoseUnitDto.MILLIMOLES_PER_LITER,
)

/**
 * Converts a [NumericDto] to a numeric value (Long for step counts).
 */
internal fun NumericDto.toLong(): Long = value.toLong()

/**
 * Converts a numeric value to a [NumericDto].
 *
 * Uses numeric unit for consistency.
 */
internal fun Number.toNumericDto(): NumericDto = NumericDto(
    value = this.toDouble(),
    unit = NumericUnitDto.NUMERIC,
)

/**
 * Converts a [PercentageDto] to a Health Connect [Percentage] object.
 */
internal fun PercentageDto.toHealthConnect(): Percentage = when (unit) {
    PercentageUnitDto.DECIMAL -> Percentage(value)
    PercentageUnitDto.WHOLE -> Percentage(value / PERCENTAGE_WHOLE_TO_DECIMAL)
}

/**
 * Converts a Health Connect [Percentage] object to a [PercentageDto].
 *
 * Uses decimal as the transfer unit for consistency (0.0 to 1.0).
 */
internal fun Percentage.toDto(): PercentageDto = PercentageDto(
    value = value,
    unit = PercentageUnitDto.DECIMAL,
)

/**
 * Converts a temperature value (Double in Celsius) to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Double.toTemperatureDto(): TemperatureDto = TemperatureDto(
    value = this,
    unit = TemperatureUnitDto.CELSIUS,
)

/**
 * Converts a [TimeDurationDto] to a Kotlin [Duration] object.
 */
internal fun TimeDurationDto.toDuration(): Duration = when (unit) {
    TimeDurationUnitDto.SECONDS -> value.seconds
    TimeDurationUnitDto.MINUTES -> value.minutes
    TimeDurationUnitDto.HOURS -> value.hours
}

/**
 * Converts a Kotlin [Duration] to a [TimeDurationDto].
 *
 * Uses seconds as the transfer unit for consistency.
 */
internal fun Duration.toDto(): TimeDurationDto = TimeDurationDto(
    value = toDouble(DurationUnit.SECONDS),
    unit = TimeDurationUnitDto.SECONDS,
)
