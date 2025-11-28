package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.SleepSessionRecord
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Converts an [AggregationMetricDto] to a Health Connect aggregation metric.
 *
 * @receiver The [AggregationMetricDto] to convert
 * @param dataType The health data type for which to get the aggregation metric
 * @return The Health Connect aggregation metric as [AggregateMetric]
 * @throws IllegalArgumentException if the metric cannot use AggregateRequest directly
 */
internal fun AggregationMetricDto.toHealthConnectMetric(dataType: HealthDataTypeDto): AggregateMetric<*> {
    return when (dataType) {
        HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
            when (this) {
                AggregationMetricDto.SUM -> ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.STEPS -> {
            when (this) {
                AggregationMetricDto.SUM -> StepsRecord.COUNT_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.WEIGHT -> {
            when (this) {
                AggregationMetricDto.AVG -> WeightRecord.WEIGHT_AVG
                AggregationMetricDto.MIN -> WeightRecord.WEIGHT_MIN
                AggregationMetricDto.MAX -> WeightRecord.WEIGHT_MAX
                AggregationMetricDto.SUM,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.DISTANCE -> {
            when (this) {
                AggregationMetricDto.SUM -> DistanceRecord.DISTANCE_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.FLOORS_CLIMBED -> {
            when (this) {
                AggregationMetricDto.SUM -> FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.HEIGHT -> {
            when (this) {
                AggregationMetricDto.AVG -> HeightRecord.HEIGHT_AVG
                AggregationMetricDto.MIN -> HeightRecord.HEIGHT_MIN
                AggregationMetricDto.MAX -> HeightRecord.HEIGHT_MAX
                AggregationMetricDto.SUM,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.HYDRATION -> {
            when (this) {
                AggregationMetricDto.SUM -> HydrationRecord.VOLUME_TOTAL
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.AVG,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
            when (this) {
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.SUM,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
            when (this) {
                AggregationMetricDto.SUM -> WheelchairPushesRecord.COUNT_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.SLEEP_SESSION -> {
            when (this) {
                AggregationMetricDto.SUM -> SleepSessionRecord.SLEEP_DURATION_TOTAL
                AggregationMetricDto.AVG,
                AggregationMetricDto.MIN,
                AggregationMetricDto.MAX,
                AggregationMetricDto.COUNT -> throw IllegalArgumentException("${this.name} not directly supported for ${dataType.name}.")
            }
        }

        HealthDataTypeDto.BODY_TEMPERATURE,
        HealthDataTypeDto.LEAN_BODY_MASS,
        HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> throw IllegalArgumentException("${dataType.name} does not support aggregation.")
    }
}

