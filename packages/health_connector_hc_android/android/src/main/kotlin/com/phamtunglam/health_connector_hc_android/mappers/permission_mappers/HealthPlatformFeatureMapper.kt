package com.phamtunglam.health_connector_hc_android.mappers.permission_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto

/**
 * Health Connect platform feature permission constants.
 * These special permissions grant additional capabilities beyond basic read/write access.
 */
private const val PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND =
    "android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND"
private const val PERMISSION_READ_HEALTH_DATA_HISTORY =
    "android.permission.health.READ_HEALTH_DATA_HISTORY"

/**
 * Converts a Health Platform Feature DTO to a Health Connect permission string.
 *
 * @receiver The [HealthPlatformFeatureDto] to convert
 * @return The Health Connect permission string corresponding to the feature
 */
internal fun HealthPlatformFeatureDto.toHealthConnect(): String = when (this) {
    HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND ->
        PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND

    HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY ->
        PERMISSION_READ_HEALTH_DATA_HISTORY
}

/**
 * Converts a Health Connect permission string back to a [HealthPlatformFeatureDto].
 *
 * @receiver The Health Connect permission string to parse
 * @return The corresponding [HealthPlatformFeatureDto]
 * @throws UnsupportedOperationException if the permission string doesn't match a known
 *         platform feature or represents a feature not supported by this application
 */
@Throws(UnsupportedOperationException::class)
internal fun String.toHealthPlatformFeatureDto(): HealthPlatformFeatureDto = when (this) {
    PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND ->
        HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND

    PERMISSION_READ_HEALTH_DATA_HISTORY ->
        HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY

    else -> throw IllegalArgumentException(
        "Invalid/unsupported/unimplemented Health Connect feature string: '$this'",
    )
}

/**
 * Checks if this permission string represents a Health Connect platform feature permission.
 *
 * Platform feature permissions grant special capabilities like background reading or
 * historical data access, as opposed to regular data type permissions.
 *
 * @receiver The permission string to check
 * @return `true` if this is a platform feature permission, `false` otherwise
 */
internal val String.isFeaturePermission: Boolean
    get() = this == PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND ||
        this == PERMISSION_READ_HEALTH_DATA_HISTORY
