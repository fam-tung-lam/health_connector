package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.FrequencyDto

/**
 * Converts a numeric frequency value (events per minute) to a [FrequencyDto].
 */
internal fun Number.toFrequencyDto(): FrequencyDto = FrequencyDto(perMinute = this.toDouble())
