package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.NumberDto

/**
 * Converts a numeric value to a [NumberDto].
 */
internal fun Number.toNumberDto(): NumberDto = NumberDto(value = this.toDouble())
