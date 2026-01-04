package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationDto
import kotlin.time.Duration
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit

/**
 * Converts a [TimeDurationDto] to a Kotlin [Duration] object.
 */
internal fun TimeDurationDto.toDuration(): Duration = seconds.seconds

/**
 * Converts a Kotlin [Duration] to a [TimeDurationDto].
 *
 * Uses seconds as the transfer unit for consistency.
 */
internal fun Duration.toDto(): TimeDurationDto = TimeDurationDto(
    seconds = toDouble(DurationUnit.SECONDS),
)
