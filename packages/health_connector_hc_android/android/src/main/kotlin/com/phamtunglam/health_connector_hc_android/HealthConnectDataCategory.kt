package com.phamtunglam.health_connector_hc_android

/**
 * Represents the different categories of Health Connect data types based on their record structure.
 *
 * This categorization helps in implementing type-specific behavior and understanding the
 * temporal characteristics of each health data type.
 */
internal enum class HealthConnectDataCategory {
    /**
     * Interval records have both startTime and endTime, representing data over a time period.
     * Examples: Steps, Distance, ActiveCaloriesBurned, FloorsClimbed
     */
    INTERVAL_RECORD,

    /**
     * Instant records have a single timestamp (time), representing a point-in-time measurement.
     * Examples: Weight, Height, BodyTemperature, BodyFatPercentage
     */
    INSTANT_RECORD,

    /**
     * Series records contain multiple samples with individual timestamps over a time range.
     * Examples: HeartRate samples
     */
    SERIES_RECORD,

    /**
     * Session records are extended intervals that may contain stages or additional metadata.
     * Examples: Sleep sessions
     */
    SESSION_RECORD,
}
