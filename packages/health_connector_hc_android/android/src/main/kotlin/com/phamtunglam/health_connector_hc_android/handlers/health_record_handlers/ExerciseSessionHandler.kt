package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.time.toKotlinDuration

/**
 * Handler for Exercise Session records.
 *
 * Supports reading, writing, updating, deleting, and aggregating
 * exercise session data from Android Health Connect.
 */
internal class ExerciseSessionHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.EXERCISE_SESSION

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to ExerciseSessionRecord.EXERCISE_DURATION_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        // Health Connect returns java.time.Duration, so we need to cast to that type
        // and convert it to kotlin.time.Duration before calling toDto()
        val javaDuration = aggregatedValue as? java.time.Duration
            ?: throw IllegalArgumentException(
                "Aggregated value is not java.time.Duration type: ${aggregatedValue::class.qualifiedName}",
            )
        val kotlinDuration = javaDuration.toKotlinDuration()
        return kotlinDuration.toDto()
    }
}
