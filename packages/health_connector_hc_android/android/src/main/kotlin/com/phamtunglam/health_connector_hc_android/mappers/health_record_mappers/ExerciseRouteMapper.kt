package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseRoute
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteLocationDto
import java.time.Instant

/**
 * Converts a Health Connect [ExerciseRoute] to [ExerciseRouteDto].
 */
internal fun ExerciseRoute.toDto(): ExerciseRouteDto = ExerciseRouteDto(
    locations = route.map { it.toDto() },
)

/**
 * Converts a Health Connect [ExerciseRoute.Location] to [ExerciseRouteLocationDto].
 */
internal fun ExerciseRoute.Location.toDto(): ExerciseRouteLocationDto = ExerciseRouteLocationDto(
    time = time.toEpochMilli(),
    latitude = latitude,
    longitude = longitude,
    altitudeMeters = altitude?.inMeters,
    horizontalAccuracyMeters = horizontalAccuracy?.inMeters,
    verticalAccuracyMeters = verticalAccuracy?.inMeters,
)

/**
 * Converts [ExerciseRouteDto] to Health Connect [ExerciseRoute].
 */
internal fun ExerciseRouteDto.toHealthConnect(): ExerciseRoute = ExerciseRoute(
    route = locations.map { it.toHealthConnect() },
)

/**
 * Converts [ExerciseRouteLocationDto] to Health Connect [ExerciseRoute.Location].
 */
internal fun ExerciseRouteLocationDto.toHealthConnect(): ExerciseRoute.Location =
    ExerciseRoute.Location(
        time = Instant.ofEpochMilli(time),
        latitude = latitude,
        longitude = longitude,
        altitude = altitudeMeters?.let { Length.meters(it) },
        horizontalAccuracy = horizontalAccuracyMeters?.let {
            Length.meters(it)
        },
        verticalAccuracy = verticalAccuracyMeters?.let {
            Length.meters(it)
        },
    )
