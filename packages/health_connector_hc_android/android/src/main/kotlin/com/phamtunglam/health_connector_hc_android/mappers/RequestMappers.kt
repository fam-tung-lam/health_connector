package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Extension properties to get common fields from an [AggregateRequestDto].
 *
 * These extensions are needed due to a Pigeon limitation where sealed classes cannot have
 * any fields. Since [AggregateRequestDto] is a sealed class, we cannot define common fields
 * at the sealed class level. Instead, each subclass has its own fields, and these extensions
 * provide a unified way to access common fields across all aggregate request types.
 */

/**
 * Gets the start time from an [AggregateRequestDto].
 *
 * @return The start of time range in milliseconds since epoch (UTC), inclusive.
 */
internal val AggregateRequestDto.startTime: Long
    get() = when (this) {
        is CommonAggregateRequestDto -> startTime
        is BloodPressureAggregateRequestDto -> startTime
    }

/**
 * Gets the end time from an [AggregateRequestDto].
 *
 * @return The end of time range in milliseconds since epoch (UTC), exclusive.
 */
internal val AggregateRequestDto.endTime: Long
    get() = when (this) {
        is CommonAggregateRequestDto -> endTime
        is BloodPressureAggregateRequestDto -> endTime
    }

/**
 * Gets the aggregation metric from an [AggregateRequestDto].
 *
 * @return The type of aggregation to perform.
 */
internal val AggregateRequestDto.aggregationMetric: AggregationMetricDto
    get() = when (this) {
        is CommonAggregateRequestDto -> aggregationMetric
        is BloodPressureAggregateRequestDto -> aggregationMetric
    }

/**
 * Gets the health data type from an [AggregateRequestDto].
 *
 * For [CommonAggregateRequestDto], returns the actual data type.
 * For [BloodPressureAggregateRequestDto], returns [HealthDataTypeDto.BLOOD_PRESSURE].
 *
 * @return The health data type to aggregate.
 */
internal val AggregateRequestDto.dataType: HealthDataTypeDto
    get() = when (this) {
        is CommonAggregateRequestDto -> dataType
        is BloodPressureAggregateRequestDto -> HealthDataTypeDto.BLOOD_PRESSURE
    }
