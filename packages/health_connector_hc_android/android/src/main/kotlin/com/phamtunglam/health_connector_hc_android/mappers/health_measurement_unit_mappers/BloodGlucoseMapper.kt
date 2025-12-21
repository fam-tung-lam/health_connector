package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.BloodGlucose
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseUnitDto

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
