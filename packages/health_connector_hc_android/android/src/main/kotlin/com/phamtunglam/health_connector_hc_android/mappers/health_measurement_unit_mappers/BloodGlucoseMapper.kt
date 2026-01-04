package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.BloodGlucose
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto

/**
 * Converts a [BloodGlucoseDto] to a Health Connect [BloodGlucose] object.
 */
internal fun BloodGlucoseDto.toHealthConnect(): BloodGlucose =
    BloodGlucose.millimolesPerLiter(millimolesPerLiter)

/**
 * Converts a Health Connect [BloodGlucose] object to a [BloodGlucoseDto].
 *
 * Uses millimoles per liter as the transfer unit for consistency.
 */
internal fun BloodGlucose.toDto(): BloodGlucoseDto = BloodGlucoseDto(
    millimolesPerLiter = inMillimolesPerLiter,
)
